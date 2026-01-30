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

## 📖 Usage Walkthrough

1.  **Launch:** Start the application. You will be prompted for a password if authentication is set up.
2.  **Main Menu:**
    - Choose `1` to create a new database (e.g., `SchoolDB`).
    - The application automatically connects to the new database.
3.  **Database Menu:**
    - Choose `1` to create a table. You will be asked to define columns and data types.
    - Choose `4` to insert data into your table.
    - Choose `7` to select and view data formatted in the terminal.
4.  **Navigation:** Use `0` to go back to the previous menu or exit.

## 🖥️ Example Session

Here is a simulation of a user creating a database and querying a table:

```bash
$ ./DBMS.sh
Enter admin password:
Authenticated.
Hello, and welcome to DBMS CLI App!
Choose from the list below:
1. Create Database.
2. List Databases.
3. Connect to Database.
4. Drop Database.
0. Quit.
> 1

Enter the name of the new Database (letters, numbers, underscores only): CompanyDB

The CompanyDB Database has been created.

Connected to 'CompanyDB' Database.
------------------------------------------

Select from the list below:
1. Create Table
2. List Tables
3. Drop Table
4. Insert Into Table
5. Delete From Table
6. Update Table
7. Select From Table
0. Disconnect and Return to Main Menu
-------------------------------------
:> 1
Enter table name (or type 'exit' to cancel): Employees
How many columns? 2
Enter name for column 1: Name
Enter data type (string/number): string
Name column has been added.
Enter name for column 2: Position
Enter data type (string/number): string
Position column has been added.
Table 'Employees' created successfully with 2 columns.

Select from the list below:
1. Create Table
2. List Tables
3. Drop Table
4. Insert Into Table
5. Delete From Table
6. Update Table
7. Select From Table
0. Disconnect and Return to Main Menu
-------------------------------------
:> 4
Enter the table name (or type 'exit' to cancel): Employees
Enter value for 'Name' (string): Alice
Enter value for 'Position' (string): Manager
Row inserted successfully: 1:Alice:Manager
Do you want to insert another row? (y/n): y
Enter value for 'Name' (string): Bob
Enter value for 'Position' (string): Developer
Row inserted successfully: 2:Bob:Developer
Do you want to insert another row? (y/n): n
Returning to menu...

Select from the list below:
1. Create Table
2. List Tables
3. Drop Table
4. Insert Into Table
5. Delete From Table
6. Update Table
7. Select From Table
0. Disconnect and Return to Main Menu
-------------------------------------
:> 7

Enter the table name to view (or 'exit' to cancel): Employees
Do you want to filter rows? (y/n): n
Table: Employees
ID                  Name                Position
------------------------------------------------------------
1                   Alice               Manager
2                   Bob                 Developer

Select from the list below:
1. Create Table
2. List Tables
3. Drop Table
4. Insert Into Table
5. Delete From Table
6. Update Table
7. Select From Table
0. Disconnect and Return to Main Menu
-------------------------------------
:> 0
Disconnected from 'CompanyDB'. Returning to main menu...
Choose from the list below:
1. Create Database.
2. List Databases.
3. Connect to Database.
4. Drop Database.
0. Quit.
> 0
Goodbye
```

## � Project Structure

The project is modularized into separate scripts for maintainability:

- `DBMS.sh`: The main entry point and main menu handler.
- `.CreateDB.sh`, `.ListDBs.sh`, `.ConnectDB.sh`, `.DropDB.sh`: Database level operations.
- `CreatTable.sh`, `ListTables.sh`, `DropTable.sh`: Table definition operations.
- `InsertIntoTable.sh`, `SelectFromTable.sh`, `UpdateTable.sh`, `DeleteFromTable.sh`: Data manipulation operations (DML).
- `.authPassword.sh`: Handles user authentication.
