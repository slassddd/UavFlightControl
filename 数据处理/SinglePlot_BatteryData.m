fprintf('电池信息：\n');
fprintf('\t循环次数 (%d)\n',FlightLog_Original.mavlink_msg_command_battery_data.cycleTime(1));
fprintf('\t完全容量 (%.0f)\n',FlightLog_Original.mavlink_msg_command_battery_data.fullCapacity(1));
fprintf('\tlifePercent (%d%%)\n',FlightLog_Original.mavlink_msg_command_battery_data.lifePercent(1));