# 📘 Week 6 – Performance Evaluation and Optimisation

---

## 1. Objectives

The objective of **Week 6** is to evaluate the system’s performance under both idle and stressed conditions, identify potential bottlenecks, and apply targeted optimisations to improve efficiency and stability.

This phase focuses on:

- Measuring **baseline system performance**
- Performing controlled **load testing**
- Identifying **CPU, memory, disk, and network bottlenecks**
- Applying **low-risk system optimisations**
- Verifying performance improvements

This week bridges **system security** and **system efficiency**.

---

## 2. Importance of Performance Evaluation

A secure system must also be **efficient and responsive**.

Performance evaluation helps to:

- Detect hidden resource bottlenecks
- Understand system behavior under stress
- Validate that security controls do not degrade performance
- Ensure system stability before production use

Testing was conducted **remotely via SSH** to avoid graphical overhead.

---

## 3. Baseline Performance Measurement

### 3.1 Baseline Definition

Baseline performance represents the system state under **idle conditions** (no user load, no stress tests).

This provides a reference point to compare:
- Resource consumption
- Background process overhead
- Kernel scheduling behavior

### 3.2 Monitoring Tools Used

- `htop` → CPU usage and process visibility  
- `vmstat` → Memory, swap, and context switching  
- `iostat` → Disk I/O throughput and latency  
- `uptime` → Load averages  


- `htop` showing near-idle CPU usage  
- Purpose: Baseline reference  

---

## 4. Load Testing Methodology

Controlled stress tests were conducted to simulate real-world workloads and observe system response.

---

### 4.1 CPU Stress Testing

CPU load was generated using `stress-ng`.

```bash
stress-ng --cpu N --timeout 300s
```

Observed metrics:

- CPU utilization per core
- Load average increase
- Scheduler behavior

- stress-ng running
- htop showing high CPU usage
- Purpose: CPU scheduling evaluation

### 4.2 Memory Stress Testing

Memory pressure was simulated to observe RAM usage and swap behavior.

```bash
stress-ng --vm N --vm-bytes 80% --timeout 300s
```

Observed metrics:

- RAM consumption
- Swap usage
- Page faults

- vmstat output
- Purpose: Memory management analysis

### 4.3 Disk I/O Performance Testing

Disk performance was evaluated using fio.

```bash
fio --name=test --rw=readwrite --bs=4k --size=1G --numjobs=1
```

Observed metrics:

- Read/write throughput
- I/O wait time
- Disk latency


- fio results
- iotop output
- Purpose: Disk performance validation

### 4.4 Network Performance Testing

Network throughput was measured using iperf3 over the host-only network.

```bash
# On server:
iperf3 -s

# On client:
iperf3 -c <server-ip>
```

Observed metrics:

- Bandwidth
- Packet loss
- CPU overhead during transfer


- iperf3 client and server output
- Purpose: Network throughput validation

---

## 5. Bottleneck Identification
-----------------------------

Based on test results, the following observations were made:

- Memory pressure caused early swap activity
- CPU performance remained stable under sustained load
- Disk I/O latency increased under heavy read/write operations
- Network performance remained consistent

These findings guided optimisation decisions.

---

## 6. Optimisations Applied
-------------------------

### 6.1 Kernel Swappiness Optimization

Linux swap behavior was tuned to reduce unnecessary swapping.

```bash
sudo sysctl vm.swappiness=10
```

Effect:

- Prioritizes RAM usage
- Reduces disk I/O caused by swapping
- Improves responsiveness under memory pressure

![swappiness](assets/images/swap.png)
- Output confirming new value
- Purpose: Memory optimisation proof

### 6.2 Disabling Unused Services

Unused background services were identified and disabled to reduce overhead.

```bash
systemctl list-unit-files --type=service
```

Benefits:

- Reduced CPU wake-ups
- Lower memory usage
- Faster system response


- Service status output
- Purpose: Resource optimisation validation

---

## 7. Performance Comparison Summary
----------------------------------

| Area | Before Optimization | After Optimization |
|------|---------------------|-------------------|
| Swap Usage | Moderate | Minimal |
| Memory Pressure | High | Reduced |
| CPU Stability | Stable | Stable |
| Disk Overhead | Moderate | Reduced |

Optimisations improved system efficiency **without compromising security**.

---

## 8. Architecture Overview (Performance Perspective)
---------------------------------------------------

```
[ Monitoring Tools ]
       |
[ stress-ng | fio | iperf3 ]
       |
[ Kernel Scheduler & Memory Manager ]
       |
[ CPU | RAM | Disk | Network ]
```



## 9. Learning Reflection
-----------------------

This week highlighted that **performance tuning must be data-driven**.

Key takeaways:

- Baseline measurements are essential
- Optimisation without metrics is guesswork
- Small kernel tweaks can produce significant gains
- Security controls and performance must coexist

By combining **measurement, analysis, and controlled optimisation**, the system now operates in a **balanced, efficient, and secure state**, ready for final evaluation and reporting.