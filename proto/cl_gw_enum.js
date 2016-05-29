
var KC2G_Protocol = ...{};
KC2G_Protocol.c2g_protocol_begin = 1;
KC2G_Protocol.c2g_ping_signal = 2;
KC2G_Protocol.c2g_handshake_request = 3;
KC2G_Protocol.c2g_account_verify_request = 4;
KC2G_Protocol.c2g_check_role_exist_request = 5;
KC2G_Protocol.c2g_create_role_request = 6;
KC2G_Protocol.c2g_delete_role_request = 7;
KC2G_Protocol.c2g_rename_request = 8;
KC2G_Protocol.c2g_mibao_verify_request = 9;
KC2G_Protocol.c2g_protocol_total = 10;

var KG2C_Protocol = ...{};
KG2C_Protocol.g2c_protocol_begin = 1;
KG2C_Protocol.g2c_ping_respond = 2;
KG2C_Protocol.g2c_handshake_respond = 3;
KG2C_Protocol.g2c_account_locked_notify = 4;
KG2C_Protocol.g2c_account_verify_respond = 5;
KG2C_Protocol.g2c_kick_account_notify = 6;
KG2C_Protocol.g2c_sync_role_list = 7;
KG2C_Protocol.g2c_check_role_exist_respond = 8;
KG2C_Protocol.g2c_create_role_notify = 9;
KG2C_Protocol.g2c_create_role_respond = 10;
KG2C_Protocol.g2c_delete_role_respond = 11;
KG2C_Protocol.g2c_sync_login_key = 12;
KG2C_Protocol.g2c_webgateway_verify_notify = 13;
KG2C_Protocol.g2c_protocol_total = 14;
}
