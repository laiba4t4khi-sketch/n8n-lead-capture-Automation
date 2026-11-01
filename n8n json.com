{
  "name": "n8n workflow Automation- Lead to CRM & instant Email Follow-up",
  "nodes": [
    {
      "parameters": {
        "httpMethod": "POST",
        "path": "1f06faf7-f1a7-4294-b7ce-0f81afb769d5",
        "options": {}
      },
      "type": "n8n-nodes-base.webhook",
      "typeVersion": 2.2,
      "position": [
        0,
        0
      ],
      "id": "74621985-fd02-42c2-9033-8e939220803c",
      "name": "Webhook",
      "webhookId": "1f06faf7-f1a7-4294-b7ce-0f81afb769d5"
    },
    {
      "parameters": {
        "authentication": "appToken",
        "email": "laiba4t4khi@gmail.com",
        "additionalFields": {
          "firstName": "Laiba",
          "lastName": "Test"
        },
        "options": {}
      },
      "type": "n8n-nodes-base.hubspot",
      "typeVersion": 2.2,
      "position": [
        448,
        0
      ],
      "id": "7d7adb24-ee6b-46e8-8cff-b27213759b0b",
      "name": "Create or update a contact",
      "credentials": {
        "hubspotAppToken": {
          "id": "6iszpkNlAi9JNejC",
          "name": "HubSpot Service Key account 5"
        }
      }
    },
    {
      "parameters": {
        "conditions": {
          "options": {
            "caseSensitive": true,
            "leftValue": "",
            "typeValidation": "loose",
            "version": 3
          },
          "conditions": [
            {
              "id": "f92b9254-961c-4969-ba81-a225595d9d45",
              "leftValue": "={{ $json.body.email }}",
              "rightValue": "AC Repair",
              "operator": {
                "type": "string",
                "operation": "notEmpty",
                "singleValue": true
              }
            }
          ],
          "combinator": "and"
        },
        "looseTypeValidation": true,
        "options": {}
      },
      "type": "n8n-nodes-base.if",
      "typeVersion": 2.3,
      "position": [
        208,
        -48
      ],
      "id": "5915b4c4-5a65-4bb5-b6d8-c602a358c408",
      "name": "If"
    },
    {
      "parameters": {
        "fromEmail": "info@alghazitechnical.com",
        "toEmail": "=laiba4t4khi@gmail.com",
        "subject": "AC Repair Request Received - We will contact you soon!",
        "html": "=Hi {{ $('Webhook').item.json.name }},\n\nThanks for your AC Repair inquiry!\n\nWe received your request and our team will call you within 2 hours.\n\n- Al Ghazi Technical",
        "options": {}
      },
      "type": "n8n-nodes-base.emailSend",
      "typeVersion": 2.1,
      "position": [
        592,
        160
      ],
      "id": "30ac8539-5729-4509-8dd5-5fd375f9ef48",
      "name": "Send an Email",
      "webhookId": "49de5365-3f87-4d75-8b81-51119ccb0219",
      "credentials": {
        "smtp": {
          "id": "oQjVcC10hY0TrEAn",
          "name": "SMTP account"
        }
      }
    }
  ],
  "pinData": {},
  "connections": {
    "Webhook": {
      "main": [
        [
          {
            "node": "If",
            "type": "main",
            "index": 0
          }
        ]
      ]
    },
    "If": {
      "main": [
        [
          {
            "node": "Create or update a contact",
            "type": "main",
            "index": 0
          }
        ],
        []
      ]
    },
    "Create or update a contact": {
      "main": [
        [
          {
            "node": "Send an Email",
            "type": "main",
            "index": 0
          }
        ]
      ]
    }
  },
  "active": true,
  "settings": {
    "executionOrder": "v1",
    "binaryMode": "separate"
  },
  "versionId": "123d955f-56d8-4954-af98-145fc21474bb",
  "meta": {
    "templateCredsSetupCompleted": true,
    "instanceId": "84b822e82efda94597390c9b1686616b055e7b757bef075996c251443f2b5425"
  },
  "nodeGroups": [],
  "id": "ulykh7vKpWBuJK1d",
  "tags": []
}
