Feature: Transaccion
  Este servicio obtiene el numero de transaccion

  Background:
    * url baseUrlGetTrx
    * header Content-Type = 'application/json'

  @HappyPath
  Scenario: Verificar que al enviar la peticion con caja, sucursal y pais reciba cod 200

    Given path '/getTrx'
    And request
      """
        {
	      "checkout": "#(checkout)",
          "location_id": "#(location_id_long)",
          "country": "#(country)"
        }
      """
    When method POST
    Then status 200