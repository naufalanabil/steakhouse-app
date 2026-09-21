const express = require('express');
const cors = require('cors');
const midtransClient = require('midtrans-client');
const path = require('path');
const db = require('./db');
require('dotenv').config();

const app = express();
app.use(cors());
app.use(express.json());

// Serve Static Files untuk Frontend & Gambar
app.use(express.static(path.join(__dirname, 'public')));
app.use('/images', express.static(path.join(__dirname, 'public/images')));

// Inisialisasi Midtrans Snap API
const snap = new midtransClient.Snap({
    isProduction: false,
    serverKey: process.env.MIDTRANS_SERVER_KEY,
    clientKey: process.env.MIDTRANS_CLIENT_KEY
});

// ===================================================
// 📌 1. CRUD MASTER MENU (LENGKAP)
// ===================================================

// GET Semua Menu
app.get('/api/menu', async (req, res) => {
    try {
        const { kategori, search } = req.query;
        let query = 'SELECT * FROM menu WHERE 1=1';
        let params = [];

        if (kategori && kategori !== 'all') {
            query += ' AND kategori = ?';
            params.push(kategori);
        }
        if (search) {
            query += ' AND nama_menu LIKE ?';
            params.push(`%${search}%`);
        }

        const [rows] = await db.query(query, params);
        res.json({ success: true, total: rows.length, data: rows });
    } catch (err) {
        res.status(500).json({ success: false, message: err.message });
    }
});

// GET Menu Detail By ID + Reviews Bintang
app.get('/api/menu/:id', async (req, res) => {
    try {
        const [rows] = await db.query('SELECT * FROM menu WHERE id = ?', [req.params.id]);
        if (rows.length === 0) return res.status(404).json({ success: false, message: 'Menu tidak ditemukan' });

        const [reviews] = await db.query('SELECT * FROM reviews WHERE menu_id = ? ORDER BY id DESC', [req.params.id]);

        res.json({
            success: true,
            data: {
                ...rows[0],
                reviews
            }
        });
    } catch (err) {
        res.status(500).json({ success: false, message: err.message });
    }
});

// CREATE Menu Baru
app.post('/api/menu', async (req, res) => {
    try {
        const { nama_menu, kategori, harga, stok, gambar_url, deskripsi } = req.body;
        const [result] = await db.query(
            'INSERT INTO menu (nama_menu, kategori, harga, stok, gambar_url, deskripsi) VALUES (?, ?, ?, ?, ?, ?)',
            [nama_menu, kategori, harga, stok || 50, gambar_url || '/images/default.jpg', deskripsi]
        );
        res.status(201).json({ success: true, message: 'Menu berhasil ditambahkan', id: result.insertId });
    } catch (err) {
        res.status(500).json({ success: false, message: err.message });
    }
});

// UPDATE Menu & Stok
app.put('/api/menu/:id', async (req, res) => {
    try {
        const { nama_menu, kategori, harga, stok, gambar_url, deskripsi } = req.body;
        await db.query(
            'UPDATE menu SET nama_menu=?, kategori=?, harga=?, stok=?, gambar_url=?, deskripsi=? WHERE id=?',
            [nama_menu, kategori, harga, stok, gambar_url, deskripsi, req.params.id]
        );
        res.json({ success: true, message: 'Data menu berhasil diperbarui' });
    } catch (err) {
        res.status(500).json({ success: false, message: err.message });
    }
});

// DELETE Menu
app.delete('/api/menu/:id', async (req, res) => {
    try {
        await db.query('DELETE FROM menu WHERE id = ?', [req.params.id]);
        res.json({ success: true, message: 'Menu berhasil dihapus' });
    } catch (err) {
        res.status(500).json({ success: false, message: err.message });
    }
});

// GET Menu Options (Saus, Sides, Toppings)
app.get('/api/menu-options', async (req, res) => {
    try {
        const { kategori_opsi } = req.query;
        let query = 'SELECT * FROM menu_options';
        let params = [];
        if (kategori_opsi) {
            query += ' WHERE kategori_opsi = ?';
            params.push(kategori_opsi);
        }
        const [rows] = await db.query(query, params);
        res.json({ success: true, total: rows.length, data: rows });
    } catch (err) {
        res.status(500).json({ success: false, message: err.message });
    }
});

// POST Review & Rating Bintang 1-5
app.post('/api/reviews', async (req, res) => {
    try {
        const { menu_id, nama_pelanggan, rating, komentar } = req.body;
        if (rating < 1 || rating > 5) return res.status(400).json({ success: false, message: 'Rating harus antara 1-5' });

        await db.query(
            'INSERT INTO reviews (menu_id, nama_pelanggan, rating, komentar) VALUES (?, ?, ?, ?)',
            [menu_id, nama_pelanggan, rating, komentar]
        );

        // Auto Update Rata-rata Rating di Menu
        const [avgRes] = await db.query('SELECT AVG(rating) as avg_rating FROM reviews WHERE menu_id = ?', [menu_id]);
        const newAvg = Number(avgRes[0].avg_rating).toFixed(1);
        await db.query('UPDATE menu SET rating_avg = ? WHERE id = ?', [newAvg, menu_id]);

        res.status(201).json({ success: true, message: 'Ulasan rating bintang berhasil ditambahkan!' });
    } catch (err) {
        res.status(500).json({ success: false, message: err.message });
    }
});

// ===================================================
// 📌 2. MANAJEMEN MEJA & ANTREAN (1-50 MEJA)
// ===================================================
app.get('/api/tables', async (req, res) => {
    try {
        const [rows] = await db.query('SELECT * FROM tables ORDER BY nomor_meja ASC');
        res.json({ success: true, data: rows });
    } catch (err) {
        res.status(500).json({ success: false, message: err.message });
    }
});

app.patch('/api/tables/:id/status', async (req, res) => {
    try {
        const { status } = req.body;
        await db.query('UPDATE tables SET status = ? WHERE id = ?', [status, req.params.id]);
        res.json({ success: true, message: 'Status meja berhasil diperbarui' });
    } catch (err) {
        res.status(500).json({ success: false, message: err.message });
    }
});

app.get('/api/queue', async (req, res) => {
    try {
        const [rows] = await db.query("SELECT * FROM queue WHERE status IN ('menunggu', 'dipanggil') ORDER BY id ASC");
        res.json({ success: true, data: rows });
    } catch (err) {
        res.status(500).json({ success: false, message: err.message });
    }
});

app.post('/api/queue', async (req, res) => {
    try {
        const { nama_pelanggan, jumlah_orang, nomor_telepon } = req.body;
        const [count] = await db.query("SELECT COUNT(*) as total FROM queue WHERE DATE(created_at) = CURDATE()");
        const queueNo = `Q-${String(count[0].total + 1).padStart(3, '0')}`;

        const [result] = await db.query(
            'INSERT INTO queue (nomor_antrean, nama_pelanggan, jumlah_orang, nomor_telepon) VALUES (?, ?, ?, ?)',
            [queueNo, nama_pelanggan, jumlah_orang, nomor_telepon || '']
        );

        res.status(201).json({ success: true, data: { queue_id: result.insertId, nomor_antrean: queueNo } });
    } catch (err) {
        res.status(500).json({ success: false, message: err.message });
    }
});

// PATCH Update Status Antrean (menunggu -> dipanggil -> selesai)
app.patch('/api/queue/:id/status', async (req, res) => {
    try {
        const { status } = req.body;
        await db.query('UPDATE queue SET status = ? WHERE id = ?', [status, req.params.id]);
        res.json({ success: true, message: `Status antrean berhasil diubah menjadi ${status}` });
    } catch (err) {
        res.status(500).json({ success: false, message: err.message });
    }
});

// ===================================================
// 📌 3. CHECKOUT & MIDTRANS PAYMENTS
// ===================================================
app.post('/api/orders', async (req, res) => {
    const connection = await db.getConnection();
    try {
        await connection.beginTransaction();

        const { nomor_meja, nama_pelanggan, items, metode_pembayaran } = req.body;

        // A. Cek Meja Kosong
        const [table] = await connection.query('SELECT status FROM tables WHERE nomor_meja = ?', [nomor_meja]);
        if (table.length === 0) throw new Error(`Meja nomor ${nomor_meja} tidak terdaftar.`);
        if (table[0].status === 'terisi') throw new Error(`Meja nomor ${nomor_meja} sedang terisi.`);

        // B. Hitung Total & Cek Stok Menu
        let subtotal = 0;
        for (let item of items) {
            const [menu] = await connection.query('SELECT harga, stok, nama_menu FROM menu WHERE id = ?', [item.menu_id]);
            if (menu.length === 0) throw new Error(`Menu ID ${item.menu_id} tidak ada.`);
            if (menu[0].stok < item.jumlah) throw new Error(`Stok menu "${menu[0].nama_menu}" kurang (Sisa: ${menu[0].stok}).`);

            subtotal += Number(menu[0].harga) * item.jumlah;
        }

        const tax = subtotal * 0.10; // PPN 10%
        const service_charge = subtotal * 0.05; // Service Charge 5%
        const total_bayar = subtotal + tax + service_charge;

        // C. Insert Header Order
        const [orderResult] = await connection.query(
            'INSERT INTO orders (nomor_meja, nama_pelanggan, total_harga, status) VALUES (?, ?, ?, ?)',
            [nomor_meja, nama_pelanggan, total_bayar, 'pending']
        );
        const orderId = orderResult.insertId;

        // D. Insert Detail Order Items & Potong Stok Menu
        for (let item of items) {
            const [menu] = await connection.query('SELECT harga FROM menu WHERE id = ?', [item.menu_id]);
            const itemSubtotal = Number(menu[0].harga) * item.jumlah;

            await connection.query(
                'INSERT INTO order_items (order_id, menu_id, jumlah, subtotal, catatan) VALUES (?, ?, ?, ?, ?)',
                [orderId, item.menu_id, item.jumlah, itemSubtotal, item.catatan_preferensi || item.catatan || '']
            );

            // Auto deduct stok
            await connection.query('UPDATE menu SET stok = stok - ? WHERE id = ?', [item.jumlah, item.menu_id]);
        }

        // E. Ubah Status Meja jadi Terisi
        await connection.query("UPDATE tables SET status = 'terisi' WHERE nomor_meja = ?", [nomor_meja]);

        // E.1. Auto-update antrean aktif teratas menjadi selesai karena sudah mendapat meja
        await connection.query(
            "UPDATE queue SET status = 'selesai' WHERE status IN ('menunggu', 'dipanggil') ORDER BY id ASC LIMIT 1"
        );

        // F. Setup Midtrans Virtual Account / QRIS / Cash
        let vaNumber = null;
        let snapToken = null;
        const midtransOrderId = `STEAK-${orderId}-${Date.now()}`;

        if (metode_pembayaran && metode_pembayaran.includes('va') || metode_pembayaran === 'qris') {
            const parameter = {
                transaction_details: { order_id: midtransOrderId, gross_amount: Math.round(total_bayar) },
                customer_details: { first_name: nama_pelanggan }
            };
            const transaction = await snap.createTransaction(parameter);
            snapToken = transaction.token;
            vaNumber = `70012${orderId.toString().padStart(6, '0')}`;
        }

        // G. Simpan Pembayaran Log
        await connection.query(
            `INSERT INTO payments (order_id, subtotal, tax, service_charge, total_bayar, metode_pembayaran, va_number, snap_token, status_pembayaran)
             VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'pending')`,
            [orderId, subtotal, tax, service_charge, total_bayar, metode_pembayaran, vaNumber, snapToken]
        );

        await connection.commit();

        res.status(201).json({
            success: true,
            message: 'Checkout sukses! Stok terpotong, meja terisi, dan antrean tersinkronisasi.',
            data: {
                order_id: orderId,
                nomor_meja,
                subtotal,
                tax,
                service_charge,
                total_bayar,
                va_number: vaNumber,
                snap_token: snapToken
            }
        });

    } catch (err) {
        await connection.rollback();
        res.status(400).json({ success: false, message: err.message });
    } finally {
        connection.release();
    }
});

// GET All Orders untuk Dashboard Admin & Laporan
app.get('/api/orders', async (req, res) => {
    try {
        const [rows] = await db.query('SELECT * FROM orders ORDER BY id DESC');
        res.json({ success: true, data: rows });
    } catch (err) {
        res.status(500).json({ success: false, message: err.message });
    }
});

// PATCH Update Status Order di Dapur (pending -> diproses -> selesai)
app.patch('/api/orders/:id/status', async (req, res) => {
    try {
        const { status } = req.body;
        await db.query('UPDATE orders SET status = ? WHERE id = ?', [status, req.params.id]);

        // Jika status selesai, meja otomatis dikosongkan kembali
        if (status === 'selesai') {
            const [order] = await db.query('SELECT nomor_meja FROM orders WHERE id = ?', [req.params.id]);
            if (order.length > 0) {
                await db.query("UPDATE tables SET status = 'kosong' WHERE nomor_meja = ?", [order[0].nomor_meja]);
            }
        }

        res.json({ success: true, message: `Status order berhasil diubah menjadi ${status}` });
    } catch (err) {
        res.status(500).json({ success: false, message: err.message });
    }
});

// ===================================================
// 📌 4. MANAJEMEN RESERVASI MEJA (CRUD LENGKAP)
// ===================================================

// GET Semua Reservasi (Untuk Admin & Pelanggan - Diurutkan berdasarkan tanggal & jam terbaru)
app.get('/api/reservations', async (req, res) => {
    try {
        const [rows] = await db.query("SELECT * FROM reservations ORDER BY tanggal_reservasi DESC, jam_reservasi ASC");
        res.json({ success: true, data: rows });
    } catch (err) {
        res.status(500).json({ success: false, message: err.message });
    }
});

// POST Buat Reservasi Baru (Create)
app.post('/api/reservations', async (req, res) => {
    try {
        const { nomor_meja, nama_pemesan, nomor_telepon, tanggal_reservasi, jam_reservasi, jumlah_tamu } = req.body;

        const [existing] = await db.query(
            "SELECT * FROM reservations WHERE nomor_meja = ? AND tanggal_reservasi = ? AND status = 'aktif'",
            [nomor_meja, tanggal_reservasi]
        );

        if (existing.length > 0) {
            return res.status(400).json({ success: false, message: `Meja #${nomor_meja} sudah memiliki reservasi aktif pada tanggal tersebut!` });
        }

        const [result] = await db.query(
            'INSERT INTO reservations (nomor_meja, nama_pemesan, nomor_telepon, tanggal_reservasi, jam_reservasi, jumlah_tamu, status) VALUES (?, ?, ?, ?, ?, ?, ?)',
            [nomor_meja, nama_pemesan, nomor_telepon, tanggal_reservasi, jam_reservasi, jumlah_tamu, 'aktif']
        );

        res.status(201).json({ success: true, message: 'Reservasi meja berhasil dibuat!', id: result.insertId });
    } catch (err) {
        res.status(500).json({ success: false, message: err.message });
    }
});

// PUT Update Status Reservasi / Edit (Update) - Misal: ubah ke 'selesai' atau 'batal'
app.put('/api/reservations/:id', async (req, res) => {
    try {
        const { status } = req.body; 
        await db.query("UPDATE reservations SET status = ? WHERE id = ?", [status, req.params.id]);
        res.json({ success: true, message: 'Status reservasi berhasil diperbarui' });
    } catch (err) {
        res.status(500).json({ success: false, message: err.message });
    }
});

// DELETE Hapus Reservasi secara Permanen (Delete)
app.delete('/api/reservations/:id', async (req, res) => {
    try {
        await db.query("DELETE FROM reservations WHERE id = ?", [req.params.id]);
        res.json({ success: true, message: 'Data reservasi berhasil dihapus' });
    } catch (err) {
        res.status(500).json({ success: false, message: err.message });
    }
});

// ===================================================
// 📌 5. LAPORAN KEUANGAN & PENJUALAN
// ===================================================
app.get('/api/reports/summary', async (req, res) => {
    try {
        // Total Pendapatan & Jumlah Order Selesai
        const [revenueRes] = await db.query("SELECT SUM(total_harga) as total_omzet, COUNT(*) as total_transaksi FROM orders WHERE status = 'selesai'");
        
        // Menu Terlaris (Best Seller)
        const [bestSellers] = await db.query(`
            SELECT m.nama_menu, SUM(oi.jumlah) as total_terjual 
            FROM order_items oi 
            JOIN menu m ON oi.menu_id = m.id 
            GROUP BY oi.menu_id 
            ORDER BY total_terjual DESC 
            LIMIT 5
        `);

        // Daftar Transaksi Selesai untuk Tabel Laporan
        const [transactions] = await db.query("SELECT * FROM orders ORDER BY id DESC LIMIT 20");

        res.json({
            success: true,
            data: {
                total_omzet: revenueRes[0].total_omzet || 0,
                total_transaksi: revenueRes[0].total_transaksi || 0,
                best_sellers: bestSellers,
                transactions: transactions
            }
        });
    } catch (err) {
        res.status(500).json({ success: false, message: err.message });
    }
});

// Midtrans Webhook Notification Handler
app.post('/api/payments/midtrans-notification', async (req, res) => {
    const connection = await db.getConnection();
    try {
        const { transaction_status, order_id } = req.body;
        const realOrderId = order_id.split('-')[1];

        if (transaction_status === 'settlement' || transaction_status === 'capture') {
            await connection.beginTransaction();

            await connection.query("UPDATE payments SET status_pembayaran = 'lunas' WHERE order_id = ?", [realOrderId]);
            await connection.query("UPDATE orders SET status = 'selesai' WHERE id = ?", [realOrderId]);

            // Kosongkan kembali Meja
            const [order] = await connection.query("SELECT nomor_meja FROM orders WHERE id = ?", [realOrderId]);
            if (order.length > 0) {
                await connection.query("UPDATE tables SET status = 'kosong' WHERE nomor_meja = ?", [order[0].nomor_meja]);
            }

            await connection.commit();
        }
        res.status(200).json({ status: 'OK' });
    } catch (err) {
        await connection.rollback();
        res.status(500).json({ status: 'error', message: err.message });
    } finally {
        connection.release();
    }
});

// Jalankan Server pada Port yang Ditentukan
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => console.log(`🚀 Server Steakhouse running on http://localhost:${PORT}`));