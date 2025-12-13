-- =====================================================
-- EduSched AI - Database Schema
-- สร้างตารางสำหรับระบบจัดตารางสอนอัตโนมัติ
-- =====================================================

-- ลบ Database เก่า (ถ้ามี) และสร้างใหม่
-- CREATE DATABASE IF NOT EXISTS edusched_ai CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
-- USE edusched_ai;

-- =====================================================
-- 1. ตาราง Departments (แผนกวิชา)
-- =====================================================
CREATE TABLE IF NOT EXISTS departments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- 2. ตาราง Class Levels (ระดับชั้น)
-- =====================================================
CREATE TABLE IF NOT EXISTS class_levels (
    id INT AUTO_INCREMENT PRIMARY KEY,
    level VARCHAR(100) NOT NULL,
    departmentId INT NOT NULL,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (departmentId) REFERENCES departments(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- 3. ตาราง Teachers (ครูผู้สอน)
-- =====================================================
CREATE TABLE IF NOT EXISTS teachers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    departmentId INT,
    roomId INT,
    maxHoursPerWeek INT DEFAULT 20,
    birthdate DATE,
    unavailableTimes JSON DEFAULT NULL,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (departmentId) REFERENCES departments(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- 4. ตาราง Students (นักเรียน)
-- =====================================================
CREATE TABLE IF NOT EXISTS students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    classLevelId INT,
    departmentId INT,
    birthdate DATE,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (classLevelId) REFERENCES class_levels(id) ON DELETE SET NULL,
    FOREIGN KEY (departmentId) REFERENCES departments(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- 5. ตาราง Rooms (ห้องเรียน)
-- =====================================================
CREATE TABLE IF NOT EXISTS rooms (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    type ENUM('ห้องเรียน', 'ห้องปฏิบัติการ', 'ห้องคอมพิวเตอร์', 'ห้องประชุม', 'โรงฝึกงาน', 'อื่นๆ') DEFAULT 'ห้องเรียน',
    capacity INT DEFAULT 40,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- 6. ตาราง Subjects (รายวิชา)
-- =====================================================
CREATE TABLE IF NOT EXISTS subjects (
    id INT AUTO_INCREMENT PRIMARY KEY,
    code VARCHAR(50) NOT NULL UNIQUE,
    name VARCHAR(255) NOT NULL,
    credit INT DEFAULT 3,
    theoryHours INT DEFAULT 2,
    practiceHours INT DEFAULT 2,
    departmentId INT,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (departmentId) REFERENCES departments(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- 7. ตาราง Curriculum (หลักสูตร)
-- =====================================================
CREATE TABLE IF NOT EXISTS curriculum (
    id INT AUTO_INCREMENT PRIMARY KEY,
    classLevelId INT NOT NULL,
    subjectId INT NOT NULL,
    teacherId INT,
    roomId INT,
    hoursPerWeek INT DEFAULT 2,
    term VARCHAR(20) DEFAULT '1/2567',
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (classLevelId) REFERENCES class_levels(id) ON DELETE CASCADE,
    FOREIGN KEY (subjectId) REFERENCES subjects(id) ON DELETE CASCADE,
    FOREIGN KEY (teacherId) REFERENCES teachers(id) ON DELETE SET NULL,
    FOREIGN KEY (roomId) REFERENCES rooms(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- 8. ตาราง Schedule (ตารางสอน)
-- =====================================================
CREATE TABLE IF NOT EXISTS schedule (
    id INT AUTO_INCREMENT PRIMARY KEY,
    term VARCHAR(20) NOT NULL DEFAULT '1/2567',
    day VARCHAR(20) NOT NULL,
    start_period INT NOT NULL,
    end_period INT NOT NULL,
    subjectId INT NOT NULL,
    teacherId INT NOT NULL,
    classLevelId INT NOT NULL,
    roomId INT,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (subjectId) REFERENCES subjects(id) ON DELETE CASCADE,
    FOREIGN KEY (teacherId) REFERENCES teachers(id) ON DELETE CASCADE,
    FOREIGN KEY (classLevelId) REFERENCES class_levels(id) ON DELETE CASCADE,
    FOREIGN KEY (roomId) REFERENCES rooms(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- 9. ตาราง Users (ผู้ใช้งาน)
-- =====================================================
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    role ENUM('admin', 'teacher', 'student') DEFAULT 'student',
    teacherId INT,
    studentId INT,
    image VARCHAR(500),
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (teacherId) REFERENCES teachers(id) ON DELETE SET NULL,
    FOREIGN KEY (studentId) REFERENCES students(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- 10. ตาราง Logs (ประวัติการใช้งาน)
-- =====================================================
CREATE TABLE IF NOT EXISTS logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    userId INT,
    action VARCHAR(255) NOT NULL,
    details TEXT,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (userId) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- ข้อมูลเริ่มต้น (Sample Data)
-- =====================================================

-- Admin User (password: admin123)
INSERT INTO users (username, password, name, role) VALUES 
('admin', '$2b$10$rQZ8k.HGlPxnJbxE5Yt5h.YM0M5LZfJt5QPKL8kG0xqeKvQ1T2W3C', 'ผู้ดูแลระบบ', 'admin')
ON DUPLICATE KEY UPDATE name = VALUES(name);

-- =====================================================
-- Index สำหรับเพิ่มประสิทธิภาพ
-- =====================================================
CREATE INDEX idx_schedule_term ON schedule(term);
CREATE INDEX idx_schedule_day ON schedule(day);
CREATE INDEX idx_schedule_teacher ON schedule(teacherId);
CREATE INDEX idx_schedule_class ON schedule(classLevelId);
CREATE INDEX idx_curriculum_class ON curriculum(classLevelId);
CREATE INDEX idx_students_class ON students(classLevelId);
CREATE INDEX idx_teachers_dept ON teachers(departmentId);

-- =====================================================
-- เสร็จสิ้น!
-- =====================================================
SELECT 'Database schema created successfully!' AS status;
