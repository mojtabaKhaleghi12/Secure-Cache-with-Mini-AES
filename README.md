
# 🛡️ Secure Cache with Mini-AES (VHDL)

## 📌 Project Overview
This project implements a **Secure Cache** using **VHDL**, where data is **encrypted before being stored** in the cache and **decrypted when read back**.

A simplified version of the **AES algorithm (Mini-AES, 16-bit)** is used for encryption and decryption.  
The goal of the project is to combine concepts from:

- Digital Design
- Hardware Cryptography
- Cache Memory Architecture
- Synchronous RTL Design

---

## 🧠 System Architecture
## Write Path
Data_in ──► AES Encoder ──► Cache (Encrypted Data)
## Read Path
Cache (Encrypted Data) ──► AES Decoder ──► Data_out

The cache is implemented as a **Direct-Mapped Cache** with:
- Valid bit
- Tag
- Encrypted data storage

---

## 🔐 Mini-AES Encryption Algorithm

### Encryption (AES Encoder)
Each encryption round consists of the following steps:
1. **SubBytes**
2. **ShiftRows**
3. **MixColumns**
4. **AddRoundKey**

The encoder performs **2 encryption rounds** on 16-bit data.

---

### Decryption (AES Decoder)
The decryption process applies the **inverse operations in reverse order**:
1. **AddRoundKey**
2. **Inverse MixColumns**
3. **Inverse ShiftRows**
4. **Inverse SubBytes**

All inverse modules are implemented and verified independently.

---

### 🗂️ Project Structure
- `Aes_en.srcs/sources_1/new/` — All VHDL source files  
- `Aes_en.srcs/sim_1/new/` — AES Encoder testbench  
- `Aes_en.srcs/sim_2/new/` — AES Decoder testbench
- `Aes_en.srcs/cache_TestBeanch/new/` — Secure Cache with Mini-AES testbench
  
## ⏱️ Synchronous Design Notes

  AES Encoder and Decoder are purely combinational
  
  Cache memory is synchronous (clocked)
  
  Encrypted data is captured at the clock edge before being stored
  
  Registered debug signals are used to ensure stable waveform observation

## 🔑 Encryption Key Handling

  The encryption key (round_key) is provided as an input port:
  
  Enables easy key modification
  
  Improves testability
  
  Makes the design more modular and reusable

## 🛠️ Tools and Environment

  Language: VHDL
  
  Simulation: Vivado XSim
  
  Design Level: RTL
  
  Target: FPGA-compatible design

## 📚 Notes

  All modules are reusable and independently testable
  
  The design is fully modular
  
  Suitable for academic projects in:
  
  Computer Architecture
  
  Hardware Security
  
  Digital Systems Design

  FPGA-based Cryptography

## ✨ Conclusion
  
  This project demonstrates a complete secure cache architecture using hardware-based encryption:
  
  Data is stored in encrypted form
  
  Decryption restores the original data correctly
  
  The design is verified, modular, and synthesizable
  
  ---
  ##  Team Memmber
 https://github.com/AminMDNZ
 
 https://github.com/mojtabaKhaleghi12
 
  ---
