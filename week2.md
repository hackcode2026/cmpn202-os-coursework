# 📘 Week 2 – Security Planning and Testing Methodology

## 1. Objectives

The objective of **Week 2** is to move from a basic installation to a **structured, policy-driven environment**. This phase focuses on planning rather than immediate execution.

Key goals include:

- Establishing a **Security Baseline** based on industry best practices  
- Conducting **Threat Modeling** to identify and prioritize risks  
- Designing a **Quantitative Performance Testing Methodology** to evaluate system behavior under different conditions  

---

## 2. Security Configuration Checklist

To achieve a **hardened system state**, the following security controls were planned.  
These controls go beyond default configurations and follow a **defense-in-depth** approach.

| Control Category | Implementation Strategy | Purpose |
|-----------------|-------------------------|---------|
| Authentication | Ed25519 SSH Key-Based Authentication | Eliminates password brute-force attack vectors |
| Network Security | UFW (Uncomplicated Firewall) | Enforces the Principle of Least Privilege |
| Access Control | Non-root Admin User with sudo | Restricts direct root access |
| Updates | unattended-upgrades | Ensures automatic installation of security patches |
| Mandatory Access Control | AppArmor Hardening | Restricts application-level capabilities |
| Intrusion Prevention | Fail2Ban | Automatically blocks suspicious IP activity |

---

## 3. Threat Model

A basic **threat modeling exercise** was conducted to identify common attack vectors against a Linux server environment.

| Threat Vector | Impact | Mitigation Strategy | Risk Level |
|--------------|--------|---------------------|------------|
| SSH Brute Force | System compromise | Disable password auth, enable Fail2Ban | High |
| Lateral Movement | Unauthorized access | Isolate management using Host-Only Network | Medium |
| Privilege Escalation | Root takeover | Restrict sudoers, enforce AppArmor profiles | High |
| Service Exploits | Data breach | Automated security patching | Medium |

---

## 4. Performance Testing Methodology

System performance evaluation will be carried out using **remote monitoring and controlled stress testing**.

### 4.1 Measurement Tools

- **Resource Monitoring:** `htop`, `iotop`, `nmon`
- **Data Collection:** Custom Bash scripts using `vmstat`, `iostat`, and `/proc`
- **Stress Testing:** `stress-ng` and `iperf3` for CPU, I/O, and network load simulation

### 4.2 Testing Scenarios

- **Baseline Measurement:**  
  Recording system metrics at idle (0% load)

- **Synthetic Load Testing:**  
  Gradually increasing CPU and disk I/O load to identify bottlenecks

- **Network Throughput Testing:**  
  Measuring bandwidth and latency over the Host-Only interface

- **Security Overhead Analysis:**  
  Evaluating performance impact of AppArmor and firewall rules

---

## 5. Learning Reflection

Planning security **before implementation** is a critical professional practice.  
It prevents reactive security, where protections are added only after failures occur.

A key trade-off identified this week is **Security vs Usability**.  
For example, restricting SSH access to a single workstation IP significantly increases security but reduces flexibility.

In production environments, this **Zero Trust approach** is standard practice.  
This phase reinforced the understanding that an operating system is not just a platform for applications, but a **living system requiring continuous proactive management**.
