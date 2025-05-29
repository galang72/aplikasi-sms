-- Create login_details
CREATE TABLE login_details (
    id VARCHAR(12) PRIMARY KEY NOT NULL,
    uname VARCHAR(45) NOT NULL,
    password VARCHAR(255) NOT NULL,
    typeofuser VARCHAR(45) NOT NULL
);

-- Insert super admin (dummy values - edit as needed)
INSERT INTO login_details VALUES ('AD1000', 'admin', MD5('admin123'), 'superadmin');

-- Admin table
CREATE TABLE admin (
    id VARCHAR(8) PRIMARY KEY NOT NULL,
    name VARCHAR(45) NOT NULL UNIQUE,
    address TEXT NOT NULL,
    phoneno BIGINT NOT NULL,
    age INT NOT NULL,
    sex VARCHAR(10) NOT NULL
);

-- Function: Generate correct admin ID
DELIMITER &&
CREATE FUNCTION get_correct_fid(idi VARCHAR(8))
RETURNS VARCHAR(8)
DETERMINISTIC
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE rore VARCHAR(8);
    DECLARE noofro INT;
    DECLARE ex_id INT;
    SELECT COUNT(*) INTO noofro FROM admin;
    id_loop: LOOP
        IF i >= noofro THEN RETURN idi; END IF;
        SELECT id INTO rore FROM admin ORDER BY id LIMIT 1 OFFSET i;
        SELECT SUBSTRING(rore, 3, 5) INTO ex_id;
        IF rore = idi THEN
            SET ex_id = ex_id + 1;
            SET idi = CONCAT('AD', ex_id);
        END IF;
        SET i = i + 1;
    END LOOP;
END &&
DELIMITER ;

-- Procedure to add admin
DELIMITER &&
CREATE PROCEDURE addadmin(
    IN name VARCHAR(255),
    IN address TEXT,
    IN phoneno BIGINT,
    IN age INT,
    IN sex VARCHAR(10)
)
BEGIN
    DECLARE countad INT DEFAULT 0;
    DECLARE i INT DEFAULT 1000;
    DECLARE idreturn VARCHAR(8);
    SELECT COUNT(*) INTO countad FROM admin;
    SET i = countad + i;
    SET idreturn = CONCAT('AD', i);
    INSERT INTO admin VALUES (get_correct_fid(idreturn), name, address, phoneno, age, sex);
END &&
DELIMITER ;

-- Trigger: delete login when admin deleted
DELIMITER &&
CREATE TRIGGER auto_delete_login
AFTER DELETE ON admin
FOR EACH ROW
BEGIN
    DELETE FROM login_details WHERE id = OLD.id;
END &&
DELIMITER ;

-- Faculty table
CREATE TABLE faculty (
    id VARCHAR(8) PRIMARY KEY NOT NULL,
    first_name VARCHAR(45) NOT NULL,
    middle_name VARCHAR(45) NOT NULL,
    last_name VARCHAR(45) NOT NULL,
    experience INT NOT NULL,
    doj DATE NOT NULL,
    dob DATE NOT NULL,
    email VARCHAR(255) NOT NULL,
    sub VARCHAR(255) NOT NULL,
    address TEXT NOT NULL,
    qualification TEXT NOT NULL,
    age INT NOT NULL,
    sex VARCHAR(8) NOT NULL,
    phoneno BIGINT NOT NULL
);

-- Function for correct faculty id
DELIMITER &&
CREATE FUNCTION get_correct_aid(idi VARCHAR(8))
RETURNS VARCHAR(8)
DETERMINISTIC
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE rore VARCHAR(8);
    DECLARE noofro INT;
    DECLARE ex_id INT;
    SELECT COUNT(*) INTO noofro FROM faculty;
    id_loop: LOOP
        IF i >= noofro THEN RETURN idi; END IF;
        SELECT id INTO rore FROM faculty ORDER BY id LIMIT 1 OFFSET i;
        SELECT SUBSTRING(rore, 3, 5) INTO ex_id;
        IF rore = idi THEN
            SET ex_id = ex_id + 1;
            SET idi = CONCAT('FT', ex_id);
        END IF;
        SET i = i + 1;
    END LOOP;
END &&
DELIMITER ;

-- Procedure to add faculty
DELIMITER &&
CREATE PROCEDURE addfaculty(
    IN fn VARCHAR(45), IN mn VARCHAR(45), IN ln VARCHAR(45),
    IN exp INT, IN doj DATE, IN dob DATE,
    IN email VARCHAR(255), IN sub VARCHAR(255),
    IN address TEXT, IN quali TEXT, IN age INT,
    IN sex VARCHAR(8), IN phone BIGINT
)
BEGIN
    DECLARE countad INT DEFAULT 0;
    DECLARE i INT DEFAULT 10000;
    DECLARE idreturn VARCHAR(8);
    SELECT COUNT(*) INTO countad FROM faculty;
    SET i = countad + i;
    SET idreturn = CONCAT('FT', i);
    INSERT INTO faculty VALUES (
        get_correct_aid(idreturn), fn, mn, ln, exp, doj, dob, email,
        sub, address, quali, age, sex, phone
    );
END &&
DELIMITER ;

-- Trigger: auto delete login and div_details when faculty deleted
DELIMITER &&
CREATE TRIGGER auto_delete_login_faculty
AFTER DELETE ON faculty
FOR EACH ROW
BEGIN
    DELETE FROM login_details WHERE id = OLD.id;
    DELETE FROM div_details WHERE faculty_id = OLD.id;
END &&
DELIMITER ;

-- Student table
CREATE TABLE student (
    id VARCHAR(8) NOT NULL PRIMARY KEY,
    first_name VARCHAR(45) NOT NULL,
    middle_name VARCHAR(45) NOT NULL,
    last_name VARCHAR(45) NOT NULL,
    roll_no INT NOT NULL,
    division CHAR(1) NOT NULL,
    address TEXT NOT NULL,
    phoneno BIGINT NOT NULL,
    father_name VARCHAR(100) NOT NULL,
    mother_name VARCHAR(100) NOT NULL,
    std INT NOT NULL,
    dob DATE NOT NULL,
    bloodgroup CHAR(4),
    doa DATE NOT NULL,
    father_occ VARCHAR(100),
    mother_occ VARCHAR(100),
    father_phoneno BIGINT NOT NULL,
    sex VARCHAR(10) NOT NULL
);

-- Function to generate correct student id
DELIMITER &&
CREATE FUNCTION get_correct_sid(idi VARCHAR(8))
RETURNS VARCHAR(8)
DETERMINISTIC
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE rore VARCHAR(8);
    DECLARE noofro INT;
    DECLARE ex_id INT;
    SELECT COUNT(*) INTO noofro FROM student;
    id_loop: LOOP
        IF i >= noofro THEN RETURN idi; END IF;
        SELECT id INTO rore FROM student ORDER BY id LIMIT 1 OFFSET i;
        SELECT SUBSTRING(rore, 3, 5) INTO ex_id;
        IF rore = idi THEN
            SET ex_id = ex_id + 1;
            SET idi = CONCAT('ST', ex_id);
        END IF;
        SET i = i + 1;
    END LOOP;
END &&
DELIMITER ;

-- Procedure to add student
DELIMITER &&
CREATE PROCEDURE addstudent(
    IN f_name VARCHAR(45), IN m_name VARCHAR(45), IN l_name VARCHAR(45),
    IN rolno INT, IN divi CHAR(1), IN addr TEXT, IN phone BIGINT,
    IN father_n VARCHAR(100), IN mother_n VARCHAR(100), IN std INT,
    IN dob DATE, IN bg CHAR(4), IN doa DATE,
    IN father_occ VARCHAR(100), IN mother_occ VARCHAR(100), IN father_phone BIGINT,
    IN sex VARCHAR(10)
)
BEGIN
    DECLARE countad INT DEFAULT 0;
    DECLARE i INT DEFAULT 10000;
    DECLARE idreturn VARCHAR(8);
    SELECT COUNT(*) INTO countad FROM student;
    SET i = countad + i;
    SET idreturn = CONCAT('ST', i);
    INSERT INTO student VALUES (
        get_correct_sid(idreturn), f_name, m_name, l_name,
        rolno, divi, addr, phone, father_n, mother_n,
        std, dob, bg, doa, father_occ, mother_occ, father_phone, sex
    );
END &&
DELIMITER ;

-- Trigger: delete login when student deleted
DELIMITER &&
CREATE TRIGGER dele_student_login
AFTER DELETE ON student
FOR EACH ROW
BEGIN
    DELETE FROM login_details WHERE id = OLD.id;
END &&
DELIMITER ;

-- div_details table (class assignment)
CREATE TABLE div_details (
    std INT,
    division CHAR(1),
    faculty_id VARCHAR(8),
    FOREIGN KEY (faculty_id) REFERENCES faculty(id)
);

-- Fees master
CREATE TABLE store_fees (
    year_ YEAR NOT NULL PRIMARY KEY,
    monthly INT,
    yearly INT
);

-- Fees table
CREATE TABLE fees (
    id VARCHAR(8) NOT NULL,
    fullyearpaid ENUM('Y', 'N'),
    year_ YEAR NOT NULL,
    jan ENUM('Y', 'N'), feb ENUM('Y', 'N'), mar ENUM('Y', 'N'),
    april ENUM('Y', 'N'), may ENUM('Y', 'N'), june ENUM('Y', 'N'),
    july ENUM('Y', 'N'), aug ENUM('Y', 'N'), sept ENUM('Y', 'N'),
    oct ENUM('Y', 'N'), nov ENUM('Y', 'N'), dece ENUM('Y', 'N'),
    FOREIGN KEY (id) REFERENCES student(id) ON DELETE CASCADE,
    FOREIGN KEY (year_) REFERENCES store_fees(year_)
);

-- Trigger: auto add student into fees
DELIMITER &&
CREATE TRIGGER auto_add_fees
AFTER INSERT ON student
FOR EACH ROW
BEGIN
    INSERT INTO fees VALUES (
        NEW.id, 'N', YEAR(NEW.doa), 'N','N','N','N','N','N','N','N','N','N','N','N'
    );
END &&
DELIMITER ;

-- Procedure to add fees manually
DELIMITER &&
CREATE PROCEDURE add_fees(IN id_c VARCHAR(8), IN ye YEAR)
BEGIN
    INSERT INTO fees VALUES (
        id_c, 'N', ye, 'N','N','N','N','N','N','N','N','N','N','N','N'
    );
END &&
DELIMITER ;

-- Attendance system
CREATE TABLE present (
    present_date DATE PRIMARY KEY NOT NULL
);

CREATE TABLE attendance (
    id VARCHAR(8) NOT NULL,
    attended ENUM('Y','N'),
    date_attend DATE,
    FOREIGN KEY (date_attend) REFERENCES present(present_date)
);

-- Function to get Present or Absent label
DELIMITER &&
CREATE FUNCTION get_presentee(PA CHAR(1))
RETURNS VARCHAR(45)
DETERMINISTIC
BEGIN
    IF PA = 'Y' THEN RETURN 'Present';
    ELSEIF PA = 'N' THEN RETURN 'Absent';
    END IF;
    RETURN 'Unknown';
END &&
DELIMITER ;