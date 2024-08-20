# Target-Localization-Final-Project
Target Localization using self-coordinates and measured angle - EE Final Project 

Project Overview:

This project is part of an EE final project focused on target localization using self-coordinates and measured angles. The system is designed to determine the position of a target based on sensor data and model it in MATLAB Simulink.

Project Components:
1. Simulation Model: Ship_location_simulation_model_final.slx - A Simulink model used for testing and simulating target localization scenarios.
2. Measurement Model: Ship_location_measurements_model_final.slx - A Simulink model that processes real sensor data to estimate the target location.
3. Sensor Logs: Raw sensor data recorded during tests:
    sensorlog_20240704_142451_static_target.mat - Raw sensor data for a static target scenario.
    sensorlog_20240710_172209_dynamic_target.mat - Raw sensor data for a dynamic target scenario.
4. Data Preprocessing Script: sensorlog_to_simulink.m - A MATLAB script that converts the raw sensor data into a timetable format for use in the real measurement Simulink model and creates the path and relative bearing plots.

How to use:
1. Select Sensor Log Data: Choose the appropriate sensor log file based on the scenario you want to test (static or dynamic target). Save the log file on the same folder with the sensorlog_to_simulink.m script.
2. Run Data Preprocessing: Execute the sensorlog_to_simulink.m script to convert the selected sensor log into a Simulink-compatible timetable format. In the code, choose the name of the log file you are working with.
   Update target_lat and target_long to the real target location.
4. Run the Measurement Simulink Model: Use the Ship_location_measurements_model_final.slx to process the prepared timetable and perform target localization using real measurement data. In the model, set the target_x and target_y to the target location.
5. Simulation Model: Optionally, run the Ship_location_simulation_model_final.slx for simulated scenarios before working with real data. In the model, set the target_x and target_y to the target location.

Requirements:
1. MATLAB with Simulink.
2. Sensor data files (provided in this repository).
