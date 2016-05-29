-module(cl_gw_message_pb).

-export([encode/1, encode/2, decode/2,
	 encode_c2g_hand_shake_request/1,
	 decode_c2g_hand_shake_request/1,
	 encode_c2g_get_server_list/1,
	 decode_c2g_get_server_list/1, encode_global_data/1,
	 decode_global_data/1]).

-record(c2g_hand_shake_request,
	{uportocolid, nprotocolversion, ngroupid, nnettype}).

-record(c2g_get_server_list, {}).

-record(global_data, {strprotoname, bydata}).

encode(Record) ->
    encode(erlang:element(1, Record), Record).

encode_c2g_hand_shake_request(Record)
    when is_record(Record, c2g_hand_shake_request) ->
    encode(c2g_hand_shake_request, Record).

encode_c2g_get_server_list(Record)
    when is_record(Record, c2g_get_server_list) ->
    encode(c2g_get_server_list, Record).

encode_global_data(Record)
    when is_record(Record, global_data) ->
    encode(global_data, Record).

encode(global_data, _Record) ->
    iolist_to_binary([pack(1, required,
			   with_default(_Record#global_data.strprotoname, none),
			   string, []),
		      pack(2, required,
			   with_default(_Record#global_data.bydata, none),
			   bytes, [])]);
encode(c2g_get_server_list, _Record) ->
    iolist_to_binary([]);
encode(c2g_hand_shake_request, _Record) ->
    iolist_to_binary([pack(1, required,
			   with_default(_Record#c2g_hand_shake_request.uportocolid,
					0),
			   uint32, []),
		      pack(2, required,
			   with_default(_Record#c2g_hand_shake_request.nprotocolversion,
					0),
			   int32, []),
		      pack(3, required,
			   with_default(_Record#c2g_hand_shake_request.ngroupid,
					0),
			   int32, []),
		      pack(4, required,
			   with_default(_Record#c2g_hand_shake_request.nnettype,
					0),
			   int32, [])]).

with_default(undefined, none) -> undefined;
with_default(undefined, Default) -> Default;
with_default(Val, _) -> Val.

pack(_, optional, undefined, _, _) -> [];
pack(_, repeated, undefined, _, _) -> [];
pack(FNum, required, undefined, Type, _) ->
    exit({error,
	  {required_field_is_undefined, FNum, Type}});
pack(_, repeated, [], _, Acc) -> lists:reverse(Acc);
pack(FNum, repeated, [Head | Tail], Type, Acc) ->
    pack(FNum, repeated, Tail, Type,
	 [pack(FNum, optional, Head, Type, []) | Acc]);
pack(FNum, _, Data, _, _) when is_tuple(Data) ->
    RecName = erlang:element(1, Data),
    protobuffs:encode(FNum, encode(RecName, Data), bytes);
pack(FNum, _, Data, Type, _) ->
    protobuffs:encode(FNum, Data, Type).

decode_c2g_hand_shake_request(Bytes) ->
    decode(c2g_hand_shake_request, Bytes).

decode_c2g_get_server_list(Bytes) ->
    decode(c2g_get_server_list, Bytes).

decode_global_data(Bytes) -> decode(global_data, Bytes).

decode(global_data, Bytes) ->
    Types = [{2, bydata, bytes, []},
	     {1, strprotoname, string, []}],
    Decoded = decode(Bytes, Types, []),
    to_record(global_data, Decoded);
decode(c2g_get_server_list, Bytes) ->
    Types = [],
    Decoded = decode(Bytes, Types, []),
    to_record(c2g_get_server_list, Decoded);
decode(c2g_hand_shake_request, Bytes) ->
    Types = [{4, nnettype, int32, []},
	     {3, ngroupid, int32, []},
	     {2, nprotocolversion, int32, []},
	     {1, uportocolid, uint32, []}],
    Decoded = decode(Bytes, Types, []),
    to_record(c2g_hand_shake_request, Decoded).

decode(<<>>, _, Acc) -> Acc;
decode(<<Bytes/binary>>, Types, Acc) ->
    {{FNum, WireType}, Rest} =
	protobuffs:read_field_num_and_wire_type(Bytes),
    case lists:keysearch(FNum, 1, Types) of
      {value, {FNum, Name, Type, Opts}} ->
	  {Value1, Rest1} = case lists:member(is_record, Opts) of
			      true ->
				  {V, R} = protobuffs:decode_value(WireType,
								   bytes, Rest),
				  RecVal = decode(Type, V),
				  {RecVal, R};
			      false ->
				  {V, R} = protobuffs:decode_value(WireType,
								   Type, Rest),
				  {unpack_value(V, Type), R}
			    end,
	  case lists:member(repeated, Opts) of
	    true ->
		case lists:keytake(FNum, 1, Acc) of
		  {value, {FNum, Name, List}, Acc1} ->
		      decode(Rest1, Types,
			     [{FNum, Name,
			       lists:reverse([Value1 | lists:reverse(List)])}
			      | Acc1]);
		  false ->
		      decode(Rest1, Types, [{FNum, Name, [Value1]} | Acc])
		end;
	    false ->
		decode(Rest1, Types, [{FNum, Name, Value1} | Acc])
	  end;
      false -> exit({error, {unexpected_field_index, FNum}})
    end.

unpack_value(<<Binary/binary>>, string) ->
    binary_to_list(Binary);
unpack_value(Value, _) -> Value.

to_record(global_data, DecodedTuples) ->
    lists:foldl(fun ({_FNum, Name, Val}, Record) ->
			set_record_field(record_info(fields, global_data),
					 Record, Name, Val)
		end,
		#global_data{}, DecodedTuples);
to_record(c2g_get_server_list, DecodedTuples) ->
    lists:foldl(fun ({_FNum, Name, Val}, Record) ->
			set_record_field(record_info(fields,
						     c2g_get_server_list),
					 Record, Name, Val)
		end,
		#c2g_get_server_list{}, DecodedTuples);
to_record(c2g_hand_shake_request, DecodedTuples) ->
    lists:foldl(fun ({_FNum, Name, Val}, Record) ->
			set_record_field(record_info(fields,
						     c2g_hand_shake_request),
					 Record, Name, Val)
		end,
		#c2g_hand_shake_request{}, DecodedTuples).

set_record_field(Fields, Record, Field, Value) ->
    Index = list_index(Field, Fields),
    erlang:setelement(Index + 1, Record, Value).

list_index(Target, List) -> list_index(Target, List, 1).

list_index(Target, [Target | _], Index) -> Index;
list_index(Target, [_ | Tail], Index) ->
    list_index(Target, Tail, Index + 1);
list_index(_, [], _) -> 0.

