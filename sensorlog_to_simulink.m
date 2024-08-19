file_name ='sensorlog_20240710_172209'; % Without .mat ending
load('sensorlog_20240710_172209.mat');

% Resample orientation data to match GPS timestamps
commonTimestamps = Position.Timestamp; % Use GPS timestamps as the common timestamps

% Interpolate orientation data to match GPS timestamps
bearing_resampled = interp1(Orientation.Timestamp, Orientation.X, commonTimestamps, 'linear', 'extrap');

% Convert bearing to east
bearing_resampled_east = 90 - bearing_resampled;

% Remove the date part and keep only the time part
timeOnly = datetime(commonTimestamps, 'Format', 'HH:mm:ss.SSS');

% Convert timeOnly to string to avoid date being included
timeOnlyStr = datestr(timeOnly, 'HH:MM:SS.FFF');

% Calculate seconds from the start
exp_time = seconds(timeOnly - timeOnly(1));

% Defining paremeters
lat = Position.latitude;
lon = Position.longitude;
alt = Position.altitude;
wgs84 = wgs84Ellipsoid("meter");

% Converting between coordinates systems
[X_e,Y_e,Z_e] = geodetic2ecef(wgs84,lat,lon,alt); 
[X,Y,Z] = ecef2enu(X_e,Y_e,Z_e,lat(1),lon(1),alt(1),wgs84); % Converting to local (ENU), starting point as origin

% Create three separate tables
T_X = table(X, 'VariableNames', {'X'});
T_Y = table(Y, 'VariableNames', {'Y'});
T_Bearing = table((bearing_resampled_east)*pi/180, 'VariableNames', {'Relative Bearing'});

% Convert tables to timetables
TT_X = table2timetable(T_X,'SampleRate',1);
TT_Y = table2timetable(T_Y, 'SampleRate',1);
TT_Bearing = table2timetable(T_Bearing, 'SampleRate',1);

target_lat = 32.113899260115566; % Define target latitude
target_long = 34.8045403175766; % Define target longitude
target_alt = 0; % Assuming the altitude of the target is zero or you can set it accordingly

% old target: 32.113757321807974, 34.80461201656434
% new target: 32.11287382788105, 34.80538155162566
% dynamic target 32.113899260115566, 34.8045403175766

% Convert target geodetic coordinates to ECEF coordinates
[target_X_e, target_Y_e, target_Z_e] = geodetic2ecef(wgs84, target_lat, target_long, target_alt);

% Convert target ECEF coordinates to ENU coordinates using the same origin (starting point)
[target_X, target_Y, target_Z] = ecef2enu(target_X_e, target_Y_e, target_Z_e, lat(1), lon(1), alt(1), wgs84);
target_dist = sqrt(target_X^2 + target_Y^2); % Distance to Target

figure
plot(X,Y);
hold on;
scatter(X(1), Y(1), 'g','filled'); scatter(X(end), Y(end), 'r','filled'); scatter(target_X, target_Y, 'p','filled');
title('Dynamic Target Trajectory in ENU Coordinates');
xlabel('East (meters)');
ylabel('North (meters)');
legend('path','start','end','target','FontSize',12);
grid on;


xlim([-40 40]);
ylim([-50 10]);
hold off;

figure
plot(exp_time, bearing_resampled_east);
grid on;
title('Relative Bearing - Dynamic Target');
xlabel('Sample number');
ylabel('Relative Bearing (deg)');

% Display the target coordinates in the ENU system
disp(['Target X: ', num2str(target_X)]);
disp(['Target Y: ', num2str(target_Y)]);
disp(['Target Distance: ', num2str(target_dist)]);
disp('Data collection complete. Data saved to workspace as .mat files.');
