-- 1. สร้าง/ปรับปรุงตารางสมาชิก (เพิ่ม role)
CREATE TABLE IF NOT EXISTS `users` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `username` VARCHAR(50) NOT NULL UNIQUE,
  `password` VARCHAR(255) NOT NULL,
  `fullname` VARCHAR(100) NOT NULL,
  `role` ENUM('admin', 'user') NOT NULL DEFAULT 'user',
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- สมาชิกเริ่มต้น: Username: admin | Password: password123 | Role: admin
INSERT INTO `users` (`username`, `password`, `fullname`, `role`) 
VALUES ('admin', '$2y$10$45p2R10mB7yKshEPlq82xOepg2i01K27E12qIOnqVPlOQ/K9/u9/S', 'Administrator', 'admin')
ON DUPLICATE KEY UPDATE `role`='admin';

-- 2. ตารางเก็บการตั้งค่าระบบและ API Key
CREATE TABLE IF NOT EXISTS `settings` (
  `setting_key` VARCHAR(50) PRIMARY KEY,
  `setting_value` TEXT NULL,
  `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ค่าเริ่มต้นการตั้งค่า API Gateway
INSERT INTO `settings` (`setting_key`, `setting_value`) VALUES
('api_url', 'https://api.deesms.net'),
('api_key', '391a170439c999280c211dff604b523283727b5e8126418a2137091f7568dbea'),
('throttle_threshold', '200'),
('throttle_ratio', '30')
ON DUPLICATE KEY UPDATE `setting_key`=`setting_key`;

-- 3. ตาราง Logs บันทึกประวัติ
CREATE TABLE IF NOT EXISTS `sms_logs` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `recipient` VARCHAR(20) NOT NULL,
  `message` TEXT NOT NULL,
  `sender_name` VARCHAR(50) DEFAULT NULL,
  `status` VARCHAR(20) NOT NULL,
  `status_note` VARCHAR(100) DEFAULT NULL,
  `sent_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  INDEX (`recipient`),
  INDEX (`sent_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

