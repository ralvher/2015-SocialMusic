SocialMusic2015  ![travis](https://travis-ci.org/DSI-ETSII-ULL/2015-SocialMusic.svg?branch=master)
=========
Desarrollo de sistemas informaticos.
---------------------------


Objetivo
-----

Crear una red social minima con el uso de ruby on rails. Donde se deberá utilizar el modelo vista controlador, así como su integración continua en travis. 


Funcionamiento
-----

Hay dos formas posibles de ver el funcionamiento de la aplicación, una mediante la web, gracias a Heroku, y otra desde local.

1. Visualización en Heroku
    
    Para poder ver la aplicación en dicha plataforma, haz click [aquí].
    

2. Visualización en local

    Primero se ha de clonar el repositorio de github [2015-socialmusic], de la siguiente forma: 
    
    ```sh
    user@ubuntu-hp:~$ git clone git@github.com:DSI-ETSII-ULL/2015-SocialMusic.git
    ```
    Una vez clonado el repositorio ejecute los siguientes comandos:
    
    ```sh
    user@ubuntu-hp:~/2015-socialmusic$ bundle install
    user@ubuntu-hp:~/2015-socialmusic$ rake db:migrate
    ```
    
    
    Una vez hecho todo lo anterior, procede a ejecutar *rails server*, y por defecto se empezará a ejecutar.
    
    Una vez en ejecución, abre el navegador y escribe en la barra de direcciones *localhost:3000* y accederás a la web de la aplicación.
    
  
    
    

[aquí]:https://socialmusic2015.herokuapp.com/
[2015-socialmusic]:https://github.com/DSI-ETSII-ULL/2015-SocialMusic.git

### Miembros

Raquel Álvarez Hernández
Noel Padrón Díaz
Héctor Rodriguez Báez
Óscar Trujillo Acosta

