# วิธีนำเว็บขึ้นออนไลน์ (Deployment Guide)

เนื่องจากโปรเจคนี้ใช้ **Next.js** และ **MySQL** การนำขึ้นออนไลน์จะต้องทำ 2 ส่วนคือ **ส่วนหน้าเว็บ (App)** และ **ส่วนฐานข้อมูล (Database)**

---

## วิธีที่ 1: แบบถาวร (แนะนำสำหรับส่งอาจารย์)

### ขั้นตอนที่ 1: เอา Database ขึ้น Cloud (TiDB Cloud - ฟรี)
เนื่องจากตอนนี้ Database อยู่ในเครื่องเรา (`localhost`) เว็บที่ออนไลน์จะมองไม่เห็น เราต้องย้ายไปไว้บน Cloud ก่อน
1.  สมัคร [TiDB Cloud](https://tidbcloud.com/) (ฟรีไม่ต้องผูกบัตร)
2.  สร้าง Cluster ใหม่ (เลือก **Serverless Tier** ฟรี)
3.  เมื่อสร้างเสร็จ กด **Connect** เลือก **Connect with Code**
4.  ก็อปปี้ค่าต่างๆ เก็บไว้:
    -   Host
    -   Port
    -   User
    -   Password
5.  นำไฟล์ SQL ที่ Dump จากเครื่องเรา (หรือสร้าง Table ใหม่) ไปรันบน TiDB เพื่อเตรียมข้อมูล

### ขั้นตอนที่ 2: เอาเว็บขึ้น Vercel
1.  สมัคร [Vercel](https://vercel.com/) (Login ด้วย GitHub)
2.  กด **Add New Project** -> เลือก **Import** โปรเจค `mynextjsfinal` ของเรา
3.  ในหน้า Configure Project:
    -   **Framework Preset**: Next.js (มันจะเลือกให้อัตโนมัติ)
    -   **Environment Variables** (สำคัญมาก!): กดขยายออกมาแล้วใส่ค่า Database จาก TiDB
        -   `DB_HOST` : (ใส่ Host จาก TiDB)
        -   `DB_USER` : (ใส่ User จาก TiDB)
        -   `DB_PASSWORD` : (ใส่ Password จาก TiDB)
        -   `DB_NAME` : (ชื่อ Database ที่ตั้งไว้)
4.  กด **Deploy**
5.  รอสักครู่... เมื่อเสร็จแล้วจะได้ลิงก์ `https://mynextjsfinal.vercel.app` ส่งให้คนอื่นดูได้เลย!

---

## วิธีที่ 2: แบบชั่วคราว (Ngrok - เร็วสุด ไม่ต้องย้าย DB)
ถ้าแค่อยากเปิดให้เพื่อนดูเดี๋ยวนี้ โดยไม่ต้องย้าย Database (แต่ต้องเปิดคอมทิ้งไว้)
1.  ไปที่ [ngrok.com](https://ngrok.com/) สมัครและดาวน์โหลดโปรแกรม
2.  เปิด Terminal แล้วพิมพ์คำสั่ง (หลังจากติดตั้ง):
    ```bash
    ngrok http 3000
    ```
3.  Copy ลิงก์ที่ลงท้ายด้วย `.ngrok-free.app` ส่งให้เพื่อน
4.  **ข้อเสีย**: ลิงก์จะเข้าไม่ได้ถ้าเราปิดคอม หรือปิด Terminal

---

## ⚠️ สิ่งที่ต้องตรวจสอบก่อน Deploy
1.  ไฟล์ `lib/db.js` ของคุณต้องรองรับการอ่านค่าจาก `process.env` (ผมทำให้แล้ว)
2.  ต้องมั่นใจว่าไม่มี Hardcode (เช่น `user: 'root'`) ฝังอยู่ในโค้ดโดยตรง แต่ใช้ตัวแปรแบบนี้แทน:
    ```javascript
    user: process.env.DB_USER || 'root'
    ```
