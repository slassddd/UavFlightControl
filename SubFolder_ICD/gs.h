#ifndef _GS_H_
#define _GS_H_
#include "stdint.h"
//******************************************************************************************************
/* command for factory */
#define MAVLINK_CMD_FACTORY_CMD_1             (251)
#define MAVLINK_CMD_FACTORY_CMD_2             (252)
#define MAVLINK_CMD_FACTORY_CMD_3             (253)
#define MAVLINK_CMD_FACTORY_CMD_4             (254)
#define MAVLINK_CMD_FACTORY_CMD_5             (255)
#define MAVLINK_CMD_FACTORY_CMD_6             (256)
#define MAVLINK_CMD_FACTORY_CMD_7             (257)
#define MAVLINK_CMD_FACTORY_CMD_8             (258)

#define MAVLINK_MSG_ID_RMP                    (252)

/*control information*/
#define MAVLINK_MSG_ID_COMMAND_LONG             76
	#define MAV_CMD_PREFLIGHT_CALIBRATION           241
	#define MAV_CMD_PREFLIGHT_SET_SENSOR_OFFSETS    242
	#define MAV_CMD_COMPONENT_ARM_DISARM            400
	#define MAV_CMD_PREFLIGHT_REBOOT_SHUTDOWN       246
	#define MAV_CMD_NAV_LOITER_UNLIM                17
	#define MAV_CMD_NAV_RETURN_TO_LAUNCH            20
	#define MAV_CMD_MISSION_START                   300
	#define MAV_CMD_DO_LAND_START                   189
	#define MAV_CMD_DO_SET_CAM_TRIGG_DIST           206
	#define MAV_CMD_TAKEOFF                         23
	#define MAV_CMD_HOVER                           28
	#define MAV_CMD_CONTINUE                        29
	#define MAV_CMD_GIMBAL_CHECK                    30
	#define MAV_CMD_POS_CHECK                       31
	#define MAV_CMD_CANCEL_LOWPOWER_RETURN			32
	#define MAV_CMD_CANCEL_LOWPOWER_LANDING			33
	#define MAV_CMD_Q_CHECK							34
	#define MAV_CMD_D_CHECK							35
	#define MAV_CMD_SWITCH_ALTITUDE					36
	#define MAV_CMD_SIDESLIP_INPUT					37
	#define MAV_CMD_DO_TRANS_MC						38
	#define MAV_CMD_ACCEPT_RESIS_WIND_YAW			40
	#define MAV_CMD_DO_VISION_GPS_LOITER			51
	#define MAV_CMD_QUIT_VISION_GPS_LOITER			52
	
//////////////////////////////////////////////////////
#define MAVLINK_MSG_COMMAND_ACK                 77

/*task command*/
#define MAVLINK_MSG_MISSION_ITEM                39
#define MAVLINK_MSG_MISSION_ACK                 47
#define MAVLINK_MSG_MISSION_REQUEST             40
#define MAVLINK_MSG_MISSION_SET_CURRENT         41
#define MAVLINK_MSG_MISSION_CURRENT             42
#define MAVLINK_MSG_MISSION_REQUEST_LIST        43
#define MAVLINK_MSG_MISSION_COUNT               44
#define MAVLINK_MSG_MISSION_ID                  225
#define MAVLINK_MSG_REQUEST_MISSION_ID          224
#define MAVLINK_MSG_REQUEST_POS_MISSION_ID      226
#define MAVLINK_MSG_POS_MISSION_ID              227
#define MAVLINK_MSG_ECP                         237
#define MAVLINK_MSG_ECP_ACK                     238
#define MAVLINK_MSG_ECP_KEY                     8
#define MAVLINK_MSG_TARGET_AIRSPEED             239
#define MAVLINK_MSG_RC_CHANNELS_OVERRIDE        70
#define MAVLINK_MSG_DIGICAM_CONTROL             155
#define MAVLINK_MSG_CAMERA_FEEDBACK             180

/*parameter command*/
#define MAVLINK_MSG_SET_MODE                    11
#define MAVLINK_MSG_PARAM_REQUEST_READ          20
#define MAVLINK_MSG_PARAM_REQUEST_VALUE         21
#define MAVLINK_MSG_PARAM_VALUE                 22
#define MAVLINK_MSG_PARAM_SET                   23
#define MAVLINK_MSG_SN                          3
#define MAVLINK_MSG_REQUEST_LOAD_TYPE           228
#define MAVLINK_MSG_LOAD_TYPE                   229
#define MAVLINK_MSG_PARACHUTE_CORD              249
#define MAVLINK_MSG_REQUEST_PARACHUTE_CORD_NUM  230
#define MAVLINK_MSG_FEIMA_STATUS_REQUEST        233
#define MAVLINK_MSG_FEIMA_STATUS                232

/*file command*/
#define MAVLINK_MSG_POS_REQUEST_DATA            234
#define MAVLINK_MSG_POS_COUNT                   236
#define MAVLINK_MSG_POS_DATA                    235
#define MAVLINK_MSG_LOG_REQUEST_DATA            119
#define MAVLINK_MSG_LOG_ENTRY                   118
#define MAVLINK_MSG_LOG_DATA                    120
#define MAVLINK_MSG_LOG_ERASE                   121
#define MAVLINK_MSG_LOG_REQUEST_LIST            117
#define MAVLINK_MSG_ID_LOG_REQUEST_END          122

#define MAVLINK_MSG_DIGICAM_INFO_ACK            191 

#define MAVLINK_MSG_PX4FLOW_TRACK_START         202
#define MAVLINK_MSG_TRACK_STOP                  204
#define MAVLINK_MSG_CAMERA_CMD                  205
#define MAVLINK_MSG_CAMERA_PARAM_SET            206
#define MAVLINK_MSG_CAMERA_INFO_ACK             207 
#define MAVLINK_MSG_CAMERA_CMD                  205
#define MAVLINK_MSG_CAMERA_PARAM_SET            206
#define MAVLINK_MSG_CAMERA_INFO_ACK             207         
#define MSG_GIMBAL_CONTROl											208
#define MSG_RESERVE_CONTROl											210

#define HEARTBEAT_ID                               0

//remote control
#define MAVLINK_MSG_SCALED_PRESSURE             29
#define MAVLINK_MSG_SENSOR_OFFSETS              150
#define MAVLINK_MSG_SYS_STATUS                  1
#define MAVLINK_MSG_POWER_STATUS                125
#define MAVLINK_MSG_MISSION_CURRENT             42
#define MAVLINK_MSG_GPS_RAW                     24
#define MAVLINK_MSG_NAV_CONTROLLER_OUTPUT       62
#define MAVLINK_MSG_SERVO_OUTPUT_RAW            36
#define MAVLINK_MSG_RC_CHANNELS_RAW             35//detele
#define MAVLINK_MSG_GLOBAL_POSITION_INT         33
#define MAVLINK_MSG_ATTITUDE                    30
#define MAVLINK_MSG_VFR_HUD                     74
#define MAVLINK_MSG_WIND                        168
#define MAVLINK_MSG_RANGEFINDER                 173
#define MAVLINK_MSG_SYSTEM_TIME                 2
#define MAVLINK_MSG_STATUSTEXT                  253
#define MAVLINK_GIMBAL_AXIS						76
/* ---- */
#define MAVLINK_MSG_ID_RTK_DATA1                250

//fw_updata
#define MAVLINK_MSG_UPDATE_START                50
#define MAVLINK_MSG_UPDATE_STATUES_OK           51
#define MAVLINK_MSG_UPDATE_STATUES_ERROR        52
#define MAVLINK_MSG_UPDATE_FINISH               53
#define MAVLINK_MSG_UPDATE_PARAM_GET            54
//battery_id
#define MAVLINK_MSG_COMMAND_SET_BATTERY         55
#define MAVLINK_MSG_COMMAND_BATTERY_INFO        56
#define MAVLINK_MSG_COMMAND_GAIN_CELLVOLTAGE    57
#define MAVLINK_MSG_COMMAND_CELLVOLTAGE_INFO    58
#define MAVLINK_MSG_COMMAND_GAIN_BATTERY_DATA   59
#define MAVLINK_MSG_COMMAND_BATTERY_DATA        60
#define MAVLINK_MSG_COMMAND_BATTERY_ERRORCODE	61

//#define SERIAL_CMD_START_WORK                  0X11
//#define SERIAL_CMD_ASK_PARAMENT_DATA           0X13
//#define SERIAL_CMD_ASK_FW_CRC                  0X0F
//#define SERIAL_CMD_UPDATA_HARDWARE             0X7B
//#define DEVID_FWID                             0x0A



#define TELECONTROL_CLASS                       0X7E//0XFF
#define TELEMETRY_CLASS                         0X7E

//#define TEST_MODE                             1
#define GS_USER_MODE                            1

#define TARGET_SYSTEM                           0X4D
#define TARGET_COMPONENT                        0X7E//0XbE//0X7E

//*************************************************************************************************************

//*************************************************************************************************************

#define LOAD_TYPE_SINGLE                        100
#define LOAD_TYPE_FIVE                          101
#define LOAD_TYPE_LIDAR                         102
#define LOAD_TYPE_SINGLE_STIM300                103

#define MANUAL                                  0
#define CIRCLE                                  1
#define FLY_BY_WIRE_A                           5
#define AUTO                                    10
#define RTL                                     11
#define LOITER                                  12
#define VISION_LOITER                           13
#define GUIDED                                  15
#define INITIALISING                            16

#define MAV_MODE_FLAG_SAFETY_ARMED              128
#define MAV_MODE_FLAG_MANUAL_INPUT_ENABLED      64
#define MAV_MODE_FLAG_HIL_ENABLED               32
#define MAV_MODE_FLAG_STABILIZE_ENABLED         16
#define MAV_MODE_FLAG_GUIDED_ENABLED            8
#define MAV_MODE_FLAG_AUTO_ENABLED              4
#define MAV_MODE_FLAG_TEST_ENABLED              2
#define MAV_MODE_FLAG_CUSTOM_MODE_ENABLED       1

#define Battary_Single_Core                     1
#define Battary_Multi_Core                      2
#define Battery_Remaining                       4
#define GPS_Losing_Lock                         8
#define link_Interrupt                          16
#define IMU_Fault                               32
#define Attitude_Abnormal                       64
#define Wind_Abnormal                           128


#define Parachute_Status                        1
#define Arm_DisArm_Status                       2
#define Read_Protect_Status                     4
#define Safety_Status                           8
#define arm_disable                             16
#define battery_temperature                     32
#define airspeed_abnormal                       64
#define airspeed_healthy                        128

#define MAV_SEVERITY_EMERGENCY                  0
#define MAV_SEVERITY_ALERT                      1
#define MAV_SEVERITY_CRITICAL                   2
#define MAV_SEVERITY_ERROR                      3
#define MAV_SEVERITY_WARNING                    4
#define MAV_SEVERITY_NOTICE                     5 
#define MAV_SEVERITY_INFO                       6
#define MAV_SEVERITY_DEBUG                      7
//*************************************************************************************************************

struct mynode
{
	int id;
	int (*func)(unsigned char *);
	struct mynode* next;
};


typedef struct 
{
	float	param1;
	float	param2;
	float	param3;
	float	param4;
	float	param5;
	float	param6;
	float	param7;
	unsigned short command;	
	unsigned char target_system;
	unsigned char target_component;	
	unsigned char confirmation;		
}command_long_def;


#define MISSION_LEN_MAX   1000   //Edit by niu 20180622
typedef struct 
{
	float param1;
	float param2;
	float param3;
	float param4;
	float x;
	float y;
	float z;
	unsigned short seq;
	unsigned short command;
	unsigned char target_system;
	unsigned char target_component;
	unsigned char frame;
	unsigned char current;
	unsigned char autocontinue;	
	float gm_teta;
}mission_item_def;
typedef struct __mavlink_ecp_t
{ 
 char data[17];
 char rc[17];
} mavlink_ecp_t;
typedef struct __mavlink_ecp_key_t
{
	char ecp_key[24];
	char ecp_data[16];
}mavlink_ecp_key_t;

typedef struct 
{
	unsigned short chan1_raw;
	unsigned short chan2_raw;
	unsigned short chan3_raw;
	unsigned short chan4_raw;
	unsigned short chan5_raw;
	unsigned short chan6_raw;
	unsigned short chan7_raw;
	unsigned short chan8_raw;
	unsigned char target_system;
	unsigned char target_component;
}rc_channels_override_def;
typedef struct 
{
	float extra_value;
	unsigned char target_system;
	unsigned char target_component;
	unsigned char session;
	unsigned char zoom_pos;
	char zoom_step;
	unsigned char focus_lock;
	unsigned char shot;
	unsigned char command_id;
	unsigned char extra_param;
}digicam_control_def;
typedef struct 
{
	unsigned char data_ok;
	unsigned char session;
	unsigned char extra_param;
}digicam_control_to_ap_def;
typedef struct 
{
	unsigned char cmd;
	unsigned char data[4];
	unsigned char tail;
}digicam_info_ack_def;
typedef struct 
{
	unsigned char get_ap_info_ack;
	digicam_info_ack_def ack_gs;
}digicam_info_ack_wrap_def;
typedef struct 
{
	unsigned char cmd_id_low;
	unsigned char cmd_id_high;
	unsigned char cmd_result;
}digicam_ack_def;
typedef struct 
{
	unsigned char get_ap_cmd_ack;
	digicam_ack_def ap_cmd_ack;
}digicam_cmd_ack_wrap_def;
typedef struct 
{
	uint64_t time_usec;
	int lat;
	int lng;
	unsigned int alt_msl;
	unsigned int alt_rel;
	float roll;
	float pitch;
	float yaw;
	float foc_len;
	unsigned short img_idx;
	unsigned char target_system;
	unsigned char cam_idx;
	unsigned char flags;
}camera_feedback_def;

#define param_request_read_len 74
typedef  struct 
{
	float param_value;
	unsigned short param_count;
	unsigned short param_index;
	char param_id[16];
	unsigned char param_type;
}param_request_read_def;//__attribute__((__packed))  param_request_read_def;

typedef struct
{
	unsigned short mileage;
	int flightNum;
	char radio_id[16];
	char radio_fw[16];
	char fm_id[17];
	char fc_fw[22];//niu 20171206
	unsigned short gps_fw;
	unsigned short battery_fw;
	unsigned short mag1_fw;
	unsigned short mag2_fw;
	unsigned short gm_fw;
	unsigned short esc1_fw;
	unsigned short esc2_fw;
	unsigned short esc3_fw;
	unsigned short esc4_fw;
	unsigned short sonar_fw;
	unsigned short vision_fw;
	unsigned short reserve1;
	unsigned short reserve2;
	unsigned short reserve3;
	unsigned short reserve4;	
}feima_status_def;
typedef struct 
{
	unsigned char head;
	unsigned char cmd;
	unsigned char data[8];
	unsigned char tail;

}camera_cmd_def;

typedef struct 
{
	unsigned char head;
	unsigned char cmd;
	unsigned char data1[8];
	unsigned char data2[8];
	unsigned char data3[8];
	unsigned char data4[8];
	unsigned char Data5[8];
	unsigned char tail;

}camera_param_set_def;

typedef struct 
{
	unsigned char cmd;
	unsigned char data1[10];
	unsigned char data2[10];
	unsigned char data3[10];
	unsigned char data4[10];
	unsigned char Data5[10];
	unsigned char tail;

}camera_info_ack_def;

typedef struct 
{
	unsigned int custom_mode;
	unsigned char base_mode;
//	unsigned char failure_attribute;
//	unsigned short calibration;
//	unsigned char failure_num;
//	unsigned int code0;
//	unsigned int code1;
}heartbeat_def;

typedef struct
{
	unsigned int time_boot_ms;
	float press_abs;
	float press_diff;
	unsigned short temperature;
}scaled_pressure_def;

typedef struct
{
	float mag_declination;
	int raw_press;
	int temp_offset;
	float gyro_cal_x;
	float gyro_cal_y;
	float gyro_cal_z;
	float accel_cal_x;
	float accel_cal_y;
	float accel_cal_z;
	short mag_ofs_x;
	short mag_ofs_y;
	short mag_ofs_z;
}sensor_offsets_def;

typedef struct
{
	unsigned char calibration_status;
	unsigned short calibration;
	unsigned char code_num;
	unsigned int code0;
	unsigned int code1;
	unsigned char extended_status;
    unsigned short voyage_remaining;
    float  distance;
}sys_status_def;

typedef struct
{
	unsigned short Vcc;
	unsigned short Vservo;
	unsigned short flags;	
}power_status_def;

typedef struct
{
	unsigned short pdop;
	unsigned char fix_type;
	unsigned char satellites;	
}gps_raw_def;

typedef struct
{
	float nav_roll;
	float nav_pitch;
	float xtrack_error;
	short nav_bearing;
	short target_bearing;
	unsigned short wp_dist;	
}nav_controller_output_def;

typedef struct
{
unsigned int time_boot_ms;
unsigned short servo1_raw;
unsigned short servo2_raw;
unsigned short servo3_raw;
unsigned short servo4_raw;
//unsigned short servo5_raw;
//unsigned short servo6_raw;
//unsigned short servo7_raw;
//unsigned short servo8_raw;
//unsigned char port;	
}servo_output_raw_def;

typedef struct
{
unsigned int time_boot_ms;
unsigned short chan1_raw;
unsigned short chan2_raw;
unsigned short chan3_raw;
unsigned short chan4_raw;
unsigned short chan5_raw;
unsigned short chan6_raw;
unsigned short chan7_raw;
unsigned short chan8_raw;
unsigned char port;
unsigned char rssi;
}rc_channels_raw_def;

typedef struct
{
	unsigned int time_boot_ms;
	int lat;
	int lon;
	int alt;
	int relative_alt;
	short vx;
	short vy;
	short vz;
}global_position_int_def;

typedef struct
{
	unsigned int time_boot_ms;
	float roll;
	float pitch;
	float yaw;
}attitude_def;

typedef struct
{
	float airspeed;
	float groundspeed;
	float alt;
	float climb;
	float target_airspeed;
//	unsigned short throttle;
//	unsigned short rpm;
//	float current_mileage;	
}vfr_hud_def;

typedef struct
{
	float direction;
	float speed;
	float speed_z;
}wind_def;

typedef struct
{
	float distance;
	float voltage;
}rangefinder_def;

typedef struct
{
    unsigned int time_boot_ms;	
}system_time_def;

typedef struct
{
	unsigned char severity;
	char text[50];	
}statustext_def;

typedef struct
{
	unsigned char severe_low_battery_alarm_set;
	unsigned char low_battery_alarm_set;
    unsigned char starting_self_discharge_time;	
}set_battery_def;

typedef struct
{
	unsigned short vlotage;
	int current;
	short temperature;
	char remaining;
}battery_info_def;

typedef struct
{
	unsigned short cellvoltage[8];
	
}cellvlotage_info_def;

typedef struct
{
	unsigned short fullcapacity;
	unsigned char lifepercent;
	unsigned short cycletime;
	unsigned short batteryid;
}battery_data_def;

typedef struct
{
 float fFront; ///< 
 float fBack; ///<
 float fLeft; ///
 float fRight; /// 
 uint8_t target_system; ///< System ID
 uint8_t target_component; ///< Component ID
 uint8_t Seq; ///<command seq
} mavlink_set_local_position_setpoint_t;
/* ---- */
typedef struct
{
	unsigned short LeftJoyXAxis;
	unsigned short LeftJoyYAxis;
	unsigned short RightJoyXAxis;
	unsigned short RightJoyYAxis;
	unsigned short LeftJoyZAxis;
	unsigned short RightJoyZAxis;
	/* button pressd status */
	unsigned char LeftButton1ShortPressed : 1;
	unsigned char LeftButton1LongPressed : 1;
	unsigned char LeftButton2ShortPressed : 1;
	unsigned char LeftButton2LongPressed : 1;
	unsigned char LeftButton3ShortPressed : 1;
	unsigned char LeftButton3LongPressed : 1;
	unsigned char RightButton1ShortPressed : 1;
	unsigned char RightButton1LongPressed : 1;
	unsigned char RightButton2ShortPressed : 1;
	unsigned char RightButton2LongPressed : 1;
	unsigned char RightButton3ShortPressed : 1;
	unsigned char RightButton3LongPressed : 1;
	unsigned char LeftJoyStickButtonShortPressed : 1;
	unsigned char LeftJoyStickButtonLongPressed : 1;
	unsigned char RightJoyStickButtonShortPressed : 1;
	unsigned char RightJoyStickButtonLongPressed : 1;
	/* rev */
	unsigned short rev;
	/* control status */
	unsigned int ControlStatus;
	/* num */
	unsigned int num;
	/* param7 */
	unsigned int param7;
}key_ctrl_def;

typedef struct
{
	uint16_t pitch;
	uint16_t roll;
	uint16_t yaw;
	uint16_t heading;
	uint16_t focus;
}mavlink_stream_gimbal_t;
/* ---- */
typedef struct
{
	float airspeed;
	float vspeed;
	float speed_dir;
	float target_alt;
	float target_speed;
	int16_t target_heading;
}mavlink_stream_speed_t;
//42
typedef struct
{
	uint16_t seq;
	//int16_t target_heading;
}mission_current_t;

typedef struct
{
	uint16_t count;
	uint32_t pack_cnt;
	uint16_t block_cnt;
	uint8_t data[128];
}mission_log_data_t;

typedef struct
{
	float lng_deg;
	float lat_deg;
	float hgt_m;
	float loiter_radius_m;
	float gimbal_yaw_deg;
	float gimbal_pitch_deg;
}vision_loiter_def;

int mavlink_msg_id_command_long_fun(unsigned char *databuf);
int mavlink_msg_mission_item_fun(unsigned char *databuf);//39
int mavlink_msg_mission_item_fun_reply(unsigned char *databuf);//39_reply
int mavlink_msg_mission_set_current_fun(unsigned char *databuf);
int mavlink_msg_mission_count_fun_reply(void);//44_reply
int mavlink_msg_mission_ack_fun(unsigned char *databuf);//47
int mavlink_msg_mission_id_fun(unsigned char *databuf);//225
int mavlink_msg_pos_mission_id_fun(void);//227
int mavlink_msg_eck_ack_id_fun(void);//238
int mavlink_msg_camera_feedback_fun(unsigned char mode,unsigned short img_index  );//180
int mavlink_msg_camera_feedback_fun_ok(void);//180_2
int mavlink_msg_command_ack_fun(unsigned char *databuf);//77
int mavlink_msg_param_value_fun(unsigned char *databuf);//22
void mavlink_msg_param_value_fun_list(void);//22_list
void mavlink_msg_param_value_fun_set(unsigned char *databuf);//22_set
int mavlink_msg_lode_type_fun(void);//229
int mavlink_msg_feima_status_fun(void);//232
int mavlink_msg_attitude_fun(void);//30
int heartbeat_fun(void);//0
int mavlink_msg_global_position_int_fun(void);//33
int mavlink_msg_scaled_pressure_fun(void);//29
int mavlink_msg_camera_cmd_fun(unsigned char *databuf);//205
int mavlink_msg_camera_param_set_fun(unsigned char *databuf);//206
int mavlink_msg_camera_info_ack_fun_ok(unsigned char *data,unsigned char len);//207
int mavlink_msg_camera_info_ack_fun_timeout(void);//207
int mavlink_msg_sensor_offsets_fun(void);//150
int mavlink_msg_sys_status_fun(void);//1
int mavlink_msg_power_status_fun(void);//125
int mavlink_msg_gps_raw_fun(void);//24
int mavlink_msg_nav_controller_output_fun(void);//62
int mavlink_msg_servo_output_raw_fun(void);//36
int mavlink_msg_rc_channels_raw_fun(void);//35
int mavlink_msg_vfr_hud_fun(void);//74
int mavlink_msg_wind_fun(void);//168
int mavlink_msg_rangefinder_fun(void);//173
int mavlink_msg_system_time_fun(void);//2
int mavlink_msg_scaled_pressure_fun(void);//29
int mavlink_msg_sensor_offsets_fun(void);//150
int mavlink_msg_sys_status_fun(void);//1
int mavlink_msg_power_status_fun(void);//125
int mavlink_msg_gps_raw_fun(void);//24
int mavlink_msg_nav_controller_output_fun(void);//62
void fc_param_init(void);
int mavlink_msg_camera_feedback_fun_timeout(void);//180
void mavlink_msg_update_start_fun(unsigned char *databuf,unsigned char len);//51
void mavlink_msg_update_statues_error_fun(unsigned char *databuf);//52
void mavlink_msg_update_finish_fun(unsigned char *databuf);//53
void mavlink_msg_update_param_get_fun(unsigned char *databuf , unsigned char len);//54
void mavlink_msg_command_set_battrty_fun(unsigned char *databuf);//55
void mavlink_msg_command_battery_info_fun(void);//56
void mavlink_msg_command_gain_cellvoltage_fun(void);//57
void mavlink_msg_command_cellvoltage_info_fun(void);//58
void mavlink_msg_command_gain_battery_data_fun(void);//59
void mavlink_msg_command_battery_data_fun(void);//60
int mavlink_msg_rtk_data1_fun(unsigned char *databuf);//250
int mavlink_msg_mission_current_fun(unsigned char *databuf);//42
void mavlink_msg_global_position_int_recv_fun(unsigned char *databuf); //33 add by kyx
void mileage_read(void);
void flightnum_read(void);
void sn_write(void);
void sn_read(void);
#endif


