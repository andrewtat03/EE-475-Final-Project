# EE475
# Smart Sticker System

## Overview
A distributed smart home monitoring system consisting of multiple custom PCB-based ESP32 sensor nodes that collect environmental data (temperature, humidity, ambient light) and transmit it to a Firebase cloud database for real-time monitoring via a mobile application.

This project demonstrates PCB design, embedded firmware development, cloud integration, and low-power optimization.

---

## Features
- Custom PCB sensor nodes
- Temperature, humidity, and light level monitoring
- Wi-Fi transmission to Firebase cloud database
- Real-time data visualization via mobile application
- Deep sleep power optimization for battery operation
- Scalable multi-room architecture

---

## Hardware Design
Each sensor node includes:
- Xiao ESP32S3
- Temperature/Humidity sensor(AM2302)
- Ambient light sensor(photoresistor)
- Custom PCB designed in KiCad

Multiple nodes communicate independently with the cloud backend.

---

## System Architecture

### Node Architecture
Sensor → ESP32 → Wi-Fi → Firebase → Mobile App

### Data Flow
1. Sensor data sampled
2. Data formatted as JSON and sent to Firebase
4. Mobile app retrieves and displays real-time updates

---

## Firmware Design

- Developed in C/C++
- Wi-Fi connectivity management
- JSON data formatting
- Deep sleep implementation for power efficiency
- Modular firmware structure for scalability

---

## Cloud Integration

- Firebase Realtime Database
- Structured schema for multi-room data storage
- Real-time data synchronization

---

## Mobile Application

- Displays temperature, humidity, and light data
- Supports multiple sensor nodes
- Real-time updates from Firebase



---

## Power Optimization

- Utilized ESP32 deep sleep modes
- Configured wake-up intervals for periodic sampling
- Reduced average power consumption for battery-powered deployment

---

## Key Concepts Demonstrated

- Custom PCB design
- Embedded firmware development
- Wireless communication protocols
- Cloud database integration


## Future Improvements

- Secure authentication for cloud communication
- Local mesh networking between nodes/central hub node design
- Enhanced mobile app UI

---

## Images
![image alt](https://github.com/andrewtat03/EE-475-Final-Project/blob/733cdd613ba917caa1968585df5e40a7e2e0c3ce/PCB_Front.png) ![image alt](https://github.com/andrewtat03/EE-475-Final-Project/blob/733cdd613ba917caa1968585df5e40a7e2e0c3ce/PCB_Routing.png)

KiCad PCB screenshots for sensor nodes
---
![image alt](https://github.com/andrewtat03/EE-475-Final-Project/blob/733cdd613ba917caa1968585df5e40a7e2e0c3ce/PCB_Schematic.png)

PCB schematic for sensor node
---
![image alt](https://github.com/andrewtat03/EE-475-Final-Project/blob/733cdd613ba917caa1968585df5e40a7e2e0c3ce/PCB_Housing.jpg) ![image alt](https://github.com/andrewtat03/EE-475-Final-Project/blob/fb4d774a9abd42539c986ed5b3c6317740dd777e/PCB_Bare.jpg)

Housing for the finished sensor node, as well as above view of finished PCB without housing
---
![image alt](https://github.com/andrewtat03/EE-475-Final-Project/blob/733cdd613ba917caa1968585df5e40a7e2e0c3ce/Block_Diagram.png) ![image alt](https://github.com/andrewtat03/EE-475-Final-Project/blob/733cdd613ba917caa1968585df5e40a7e2e0c3ce/Architecture.png)

Block diagram and diagram of overall functionality
---

## Author
Andrew Tat
