var _root = dcodeIO.ProtoBuf.newBuilder({})['import']({
    "package": null,
    "messages": [
        {
            "name": "GLOBAL_DATA",
            "fields": [
                {
                    "rule": "required",
                    "type": "string",
                    "name": "strProtoName",
                    "id": 1
                },
                {
                    "rule": "required",
                    "type": "bytes",
                    "name": "byData",
                    "id": 2
                }
            ]
        },
        {
            "name": "C2G_GET_SERVER_LIST",
            "fields": []
        },
        {
            "name": "C2G_HAND_SHAKE_REQUEST",
            "fields": [
                {
                    "rule": "required",
                    "type": "uint32",
                    "name": "uPortocolID",
                    "id": 1,
                    "options": {
                        "default": 0
                    }
                },
                {
                    "rule": "required",
                    "type": "int32",
                    "name": "nProtocolVersion",
                    "id": 2,
                    "options": {
                        "default": 0
                    }
                },
                {
                    "rule": "required",
                    "type": "int32",
                    "name": "nGroupID",
                    "id": 3,
                    "options": {
                        "default": 0
                    }
                },
                {
                    "rule": "required",
                    "type": "int32",
                    "name": "nNetType",
                    "id": 4,
                    "options": {
                        "default": 0
                    }
                }
            ]
        }
    ]
}).build();