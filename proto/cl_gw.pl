
enum KC2G_Protocol
{
    c2g_protocol_begin
    c2g_ping_signal
    c2g_handshake_request
    c2g_account_verify_request
	c2g_check_role_exist_request
    c2g_create_role_request
    c2g_delete_role_request
    c2g_rename_request
	c2g_mibao_verify_request
    c2g_protocol_total
}

enum KG2C_Protocol
{
    g2c_protocol_begin
    g2c_ping_respond
    g2c_handshake_respond
    g2c_account_locked_notify
    g2c_account_verify_respond
    g2c_kick_account_notify
    g2c_sync_role_list
	g2c_check_role_exist_respond
	g2c_create_role_notify
    g2c_create_role_respond
    g2c_delete_role_respond
    g2c_sync_login_key
	g2c_webgateway_verify_notify
    g2c_protocol_total
}




message GLOBAL_DATA {
	required string strProtoName = 1;
	required bytes byData = 2;
}

message C2G_GET_SERVER_LIST{

}

message C2G_HAND_SHAKE_REQUEST{
	required uint32	uPortocolID = 1[default = 0];
	required int32	nProtocolVersion = 2[default = 0];
	required int32	nGroupID = 3[default = 0];
	required int32	nNetType = 4[default = 0];
}

