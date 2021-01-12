Feature: Flujo Injection
  Este servicio obtiene todos los datos de la orden de compra ingresada

  Background:
    * url baseUrlInjection
    * header Content-Type = 'application/json'

  @Regresion
  Scenario: Verificar que al enviar la peticion para una compra mixta con Tarjeta Ripley Credito con cuotas reciba cod 200
    * def getorderidResponse = call read('classpath:common/getorderid.feature')
    * def order_number =  getorderidResponse.response.order_number
    * def gettrxResponse = call read('classpath:common/gettrx.feature')
    * string transaction_number =  gettrxResponse.response.message.transaction_number
    Given path '/selfcheckout/injection2'
    And request
    """
    {
      "channel": "#(channel)",
      "totalAmount": "10940.27",
      "ripleyCard": {
      "creditCard": true,
      "pan": "5254350034247677",
      "summary":"",
      "amountFee": "566.15",
      "fees": "5",
      "deferredMonths":1,
      "firstExpirationDate": "2020-11-05"
      },

      "checkout": "#(checkout)",
      "locationId": "#(location_id)",
      "items": [
          {
              "quantity": 3,
              "price": "2499.99",
              "discount": "300.00",
              "description": "AIRE ACON. ELUX ESX1",
              "sku": "2019132345192",
              "departmentName": "000317",
              "messagePromotion":"QA DESC. FUN 25%",
              "codePromotion": "123456",
	          "subline":"000263"
          },
	      {
              "quantity": 1,
              "price": "77.30",
              "discount": "0.00",
              "description": "Mini MHC-V81D  One box",
              "sku": "2018209243980",
              "departmentName": "000317",
              "messagePromotion":"",
              "codePromotion": "",
	          "subline":"012874"
          },
	      {
              "quantity": 2,
              "price": "799.00",
              "discount": "199.90",
              "description": "SET EDREDON NTO QUEEN BLUE STRIPES",
              "sku": "2077146287280",
              "departmentName": "000317",
              "messagePromotion":"QA DESC. FUN 25%",
              "codePromotion": "123456",
	          "subline":"011666"
          },
	      {
              "quantity": 2,
              "price": "1264.95",
              "discount": "265.00",
              "description": "14-ce0001laCi5-8250U",
              "sku": "2004209413799",
              "departmentName": "000317",
              "messagePromotion":"QA DESC. FUN 25%",
              "codePromotion": "130033",
	          "subline":"000392"
          }
      ],
      "idOrder": "#(order_number)",
      "numberTrx": "#(transaction_number)",
      "seller": {
      "dni": "49254",
      "name": "Carla Llanos"
      },
      "client": {
      "dni": "09980008",
      "email": "dc.danielatais@gmail.com",
      "firstName": "Daniela",
      "lastName": "Diaz Custodio",
      "phoneNumber": "987654321"
      },
      "country":"#(country)",
      "cardBrand": "BCRI",
      "authorizationCode": "564869"
}
    """
    When method POST
    Then status 200
    * url baseUrlGetTrx
    And path '/burnTrx'
    And request
        """
      {
	    "checkout": "#(checkout)",
	    "location_id": "#(location_id_long)",
	    "transaction_number": "#(transaction_number)",
	    "country": "#(country)"
      }
    """
    When method DELETE
    Then status 200

  @Regresion
  Scenario: Verificar que al enviar la peticion para una compra mixta con Tarjeta Ripley Credito sin cuotas reciba cod 200
    * def getorderidResponse = call read('classpath:common/getorderid.feature')
    * def order_number =  getorderidResponse.response.order_number
    * def gettrxResponse = call read('classpath:common/gettrx.feature')
    * string transaction_number =  gettrxResponse.response.message.transaction_number
    Given path '/selfcheckout/injection2'
    And request
    """
    {
      "channel": "#(channel)",
      "totalAmount": "10940.27",
      "ripleyCard": {
      "creditCard": true,
      "pan": "5254350042273384",
      "summary":"",
      "amountFee": "10940.27",
      "fees": "",
      "deferredMonths":"",
      "firstExpirationDate": ""
      },

      "checkout": "#(checkout)",
      "locationId": "#(location_id)",
      "items": [
          {
              "quantity": 3,
              "price": "2499.99",
              "discount": "300.00",
              "description": "AIRE ACON. ELUX ESX1",
              "sku": "2019132345192",
              "departmentName": "000317",
              "messagePromotion":"QA DESC. FUN 25%",
              "codePromotion": "123456",
	          "subline":"000263"
          },
	      {
              "quantity": 1,
              "price": "77.30",
              "discount": "0.00",
              "description": "Mini MHC-V81D  One box",
              "sku": "2018209243980",
              "departmentName": "000317",
              "messagePromotion":"",
              "codePromotion": "",
	          "subline":"012874"
          },
	      {
              "quantity": 2,
              "price": "799.00",
              "discount": "199.90",
              "description": "SET EDREDON NTO QUEEN BLUE STRIPES",
              "sku": "2077146287280",
              "departmentName": "000317",
              "messagePromotion":"QA DESC. FUN 25%",
              "codePromotion": "123456",
	          "subline":"011666"
          },
	      {
              "quantity": 2,
              "price": "1264.95",
              "discount": "265.00",
              "description": "14-ce0001laCi5-8250U",
              "sku": "2004209413799",
              "departmentName": "000317",
              "messagePromotion":"QA DESC. FUN 25%",
              "codePromotion": "130033",
	          "subline":"000392"
          }
      ],
      "idOrder": "#(order_number)",
      "numberTrx": "#(transaction_number)",
      "seller": {
      "dni": "49254",
      "name": "Carla Llanos"
      },
      "client": {
      "dni": "09980008",
      "email": "dc.danielatais@gmail.com",
      "firstName": "Daniela",
      "lastName": "Diaz Custodio",
      "phoneNumber": "987654321"
      },
      "country":"#(country)",
      "cardBrand": "BCRI",
      "authorizationCode": "564869"
}
    """
    When method POST
    Then status 200
    * url baseUrlGetTrx
    And path '/burnTrx'
    And request
        """
      {
	    "checkout": "#(checkout)",
	    "location_id": "#(location_id_long)",
	    "transaction_number": "#(transaction_number)",
	    "country": "#(country)"
      }
    """
    When method DELETE
    Then status 200

  @Regresion
  Scenario: Verificar que al enviar la peticion para una compra mixta con Tarjeta Ripley Debito reciba cod 200
    * def getorderidResponse = call read('classpath:common/getorderid.feature')
    * def order_number =  getorderidResponse.response.order_number
    * def gettrxResponse = call read('classpath:common/gettrx.feature')
    * string transaction_number =  gettrxResponse.response.message.transaction_number
    Given path '/selfcheckout/injection2'
    And request
    """
    {
      "channel": "#(channel)",
      "totalAmount": "10940.27",
      "ripleyCard": {
      "creditCard": true,
      "pan": "5367620006160015",
      "summary":""
      },

      "checkout": "#(checkout)",
      "locationId": "#(location_id)",
      "items": [
          {
              "quantity": 3,
              "price": "2499.99",
              "discount": "300.00",
              "description": "AIRE ACON. ELUX ESX1",
              "sku": "2019132345192",
              "departmentName": "000317",
              "messagePromotion":"QA DESC. FUN 25%",
              "codePromotion": "123456",
	          "subline":"000263"
          },
	      {
              "quantity": 1,
              "price": "77.30",
              "discount": "0.00",
              "description": "Mini MHC-V81D  One box",
              "sku": "2018209243980",
              "departmentName": "000317",
              "messagePromotion":"",
              "codePromotion": "",
	          "subline":"012874"
          },
	      {
              "quantity": 2,
              "price": "799.00",
              "discount": "199.90",
              "description": "SET EDREDON NTO QUEEN BLUE STRIPES",
              "sku": "2077146287280",
              "departmentName": "000317",
              "messagePromotion":"QA DESC. FUN 25%",
              "codePromotion": "123456",
	          "subline":"011666"
          },
	      {
              "quantity": 2,
              "price": "1264.95",
              "discount": "265.00",
              "description": "14-ce0001laCi5-8250U",
              "sku": "2004209413799",
              "departmentName": "000317",
              "messagePromotion":"QA DESC. FUN 25%",
              "codePromotion": "130033",
	          "subline":"000392"
          }
      ],
      "idOrder": "#(order_number)",
      "numberTrx": "#(transaction_number)",
      "seller": {
      "dni": "49254",
      "name": "Carla Llanos"
      },
      "client": {
      "dni": "09980008",
      "email": "dc.danielatais@gmail.com",
      "firstName": "Daniela",
      "lastName": "Diaz Custodio",
      "phoneNumber": "987654321"
      },
      "country":"#(country)",
      "cardBrand": "BCRI",
      "authorizationCode": "564869"
}
    """
    When method POST
    Then status 200
    * url baseUrlGetTrx
    And path '/burnTrx'
    And request
    """
      {
	    "checkout": "#(checkout)",
	    "location_id": "#(location_id_long)",
	    "transaction_number": "#(transaction_number)",
	    "country": "#(country)"
      }
    """
    When method DELETE
    Then status 200