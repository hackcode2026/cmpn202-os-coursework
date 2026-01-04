# 📘 Week 3 – Application Selection for Performance Testing

## 1. Objectives

The primary objective of **Week 3** is to design a **realistic and reproducible performance testing plan** by selecting representative applications that stress different subsystems of the operating system.

This phase focuses on **what to test and why**, before executing benchmarks.

Key objectives include:

- Selecting **representative workloads** that mirror real-world server usage  
- Defining **expected resource behavior** for CPU, memory, disk, and network  
- Planning a **monitoring strategy** to capture accurate performance metrics  
- Ensuring all tools are **industry-standard and reproducible**

---

## 2. Rationale for Application-Based Testing

Modern operating systems are evaluated not in isolation, but by how they behave under **application-driven load**.

Instead of synthetic benchmarks alone, this methodology:

- Separates **CPU, memory, disk, and network bottlenecks**
- Simulates **production-like conditions**
- Allows correlation between **resource usage and system stability**
- Makes results **repeatable and defensible**

Each selected application targets a **specific subsystem** of the OS kernel.

---

## 3. Application Selection Matrix

The following matrix defines the chosen workloads and their justification.

| Workload Type | Application | Subsystem Targeted | Justification |
|--------------|------------|--------------------|---------------|
| CPU-intensive | `stress-ng` | Scheduler, CPU cores | Generates controlled and scalable CPU load |
| Memory-intensive | `stress-ng` | RAM, swap, VM | Simulates memory pressure and paging behavior |
| Disk I/O | `fio` | Block I/O, filesystem | Industry-standard disk benchmarking tool |
| Network | `iperf3` | TCP/IP stack | Measures throughput, latency, and packet loss |
| Server process | `SSH` | Daemon + auth | Represents a real-world server workload |

---

## 4. Expected Resource Behavior (Hypothesis)

Before testing, expected system behavior is defined to allow **result validation**.

### 4.1 CPU Load (stress-ng)

- CPU utilization should approach configured core limits
- Load should distribute evenly across cores
- Context switching should increase under high load
- System should remain responsive to SSH

### 4.2 Memory Pressure (stress-ng)

- RAM usage should increase predictably
- Swap activity may begin under sustained pressure
- No kernel panic or OOM killer invocation expected

### 4.3 Disk I/O (fio)

- Read/write throughput should remain consistent
- Latency spikes may appear under heavy I/O
- Filesystem should remain stable without errors

### 4.4 Network Throughput (iperf3)

- Host-only interface should show stable throughput
- Packet loss should be minimal
- CPU usage should increase moderately during tests

---

## 5. Monitoring Strategy

Performance data will be collected using **real-time and snapshot-based tools**.

### Monitoring Tools

- `htop` → CPU usage, load average, process visibility  
- `iotop` → Disk I/O per process  
- `vmstat` → Memory, swap, and scheduling metrics  
- `iostat` → Disk throughput and latency  
- `/proc` → Kernel-level statistics  

All monitoring will be conducted **remotely over SSH** to avoid UI overhead.

---

## 6. Installation of Benchmarking Tools

The following command installs all required benchmarking utilities:

```bash
sudo apt update
sudo apt install stress-ng fio iperf3 -y
