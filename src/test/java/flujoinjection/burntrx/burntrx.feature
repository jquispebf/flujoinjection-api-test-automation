Feature: Delete Burn Trx
  Este servicio quema la transaccion despues de ejecutar el flujo injection

  Background:
    * url baseUrlGetTrx
    * header Content-Type = 'application/json'

  @SmokeTest
  Scenario: Verificar petición correcta para eliminar una transaccion reciba 200
    * def gettrxResponse = call read('classpath:common/gettrx.feature')
    * string transaction_number =  gettrxResponse.response.message.transaction_number
    Given path '/burnTrx'
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