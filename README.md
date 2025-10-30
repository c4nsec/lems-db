# LEMS — Library & Event Management System

> 📚 CS306 (Database Systems) project by Berat Can Satır  
> Fall 2025 · Sabancı University

## 🎯 Overview
LEMS is a university library management system that also handles on-site events and member registrations.  
Members can borrow books and register for library events.  

**Core entities:** Member, Book, Event, Loan, Registration  
**Key constraints:**  
- Unique: `email`, `isbn`  
- Checks: `copies >= 0`, `start_time < end_time`, `due_date > loan_date`

---

## 📁 Repository Structure
lems-db/
└── phase1/
    ├── CS306_Phase1_CanSatir_32531.pdf
    ├── lems_mysql.sql
    └── lems_sqlserver_azure.sql
    
---

## ☁️ Running on Azure SQL
1. Go to your Azure SQL Database → Query Editor (Preview)  
2. Copy the contents of `phase1/lems_sqlserver_azure.sql`  
3. Paste and run to create all tables and insert sample data  

---

## 🔜 Next Phases
| Phase | Description |
|-------|--------------|
| **Phase 2** | Query design, normalization & integrity constraints |
| **Phase 3** | Integration with application (backend/frontend) |

---

## 🧑‍💻 Author
**Berat Can Satır**  
📧 `can.satir@sabanciuniv.edu`
