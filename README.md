# DBMS Using Bash Shell Script

A robust Database Management System (DBMS) built entirely using Bash shell scripting. This CLI-based application allows users to create, manage, and query databases and tables directly from the terminal, storing data persistently on the hard disk.

## 🚀 Features

### Database Management

- **Create Database:** Initialize new databases (stored as directories).
- **List Databases:** View all existing databases.
- **Connect to Database:** Select a database to perform table operations.
- **Drop Database:** Delete existing databases and their contents.

### Table Management

Once connected to a database, the following operations are available:

- **Create Table:** Define table schemas with column names and data types (e.g., String, Number).
- **List Tables:** View all tables in the current database.
- **Drop Table:** Delete specific tables.
- **Insert into Table:** Add new records with data type validation and Primary Key checks.
- **Select From Table:** View data with options to display all rows or filter by specific column values.
- **Delete From Table:** Remove records based on the Primary Key.
- **Update Table:** Modify existing records with type validation.

### Security & Architecture

- **Authentication:** Secure entry with password protection upon launching the application.
- **Persistence:** Data is stored in flat files, ensuring persistence across sessions.
- **Metadata:** Table schemas are stored in separate `.meta` files to enforce data integrity.
- **User Interface:** Interactive menu-driven interface with color-coded feedback (Green for success, Red for errors).

## 🛠️ Technical Implementation

- **Language:** Bash Scripting.
- **Storage Format:**
  - Databases -> Directories.
  - Tables -> Flat files (Colon `:` separated values).
  - Metadata -> `.meta` files containing column definitions.
- **Tools Used:** `awk`, `sed`, `grep`, `mapfile`, and standard file descriptors.

## 📋 Prerequisites

Ensure you have a Bash shell environment (Linux/Unix/WSL/macOS). No external database engines are required.

## 💻 How to Run

1.  **Clone the repository:**

    ```bash
    git clone <repository-url>
    cd DBMS-Using-Bash-Shell-Script
    ```

2.  **Grant execution permissions:**

    ```bash
    chmod +x DBMS.sh
    ```

3.  **Start the application:**
    ```bash
    ./DBMS.sh
    ```

## 📂 Project Structure

The project is modularized into separate scripts for maintainability:

- `DBMS.sh`: The main entry point and main menu handler.
- `.CreateDB.sh`, `.ListDBs.sh`, `.ConnectDB.sh`, `.DropDB.sh`: Database level operations.
- `CreatTable.sh`, `ListTables.sh`, `DropTable.sh`: Table definition operations.
- `InsertIntoTable.sh`, `SelectFromTable.sh`, `UpdateTable.sh`, `DeleteFromTable.sh`: Data manipulation operations (DML).
- `.authPassword.sh`: Handles user authentication.
