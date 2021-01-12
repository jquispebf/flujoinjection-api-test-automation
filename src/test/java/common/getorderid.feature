Feature: Shopping Cart
  Este servicio obtiene el numero de orden de compra

  Background:
    * url baseUrlShopping
    * header Accept = 'application/json'

  @HappyPath
  Scenario: Verificar que al enviar la peticion reciba cod 200

    Given path '/order'

    When method GET
    Then status 200