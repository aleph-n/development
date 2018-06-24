## Dependencias
- ansible
- terraform

## Variables de entorno
- [AWS_ACCESS_KEY_ID](#AWS_ACCESS_KEY_ID)
- [AWS_SECRET_ACCESS_KEY](#AWS_SECRET_ACCESS_KEY)
- [AWS_DEFAULT_REGION](#AWS_DEFAULT_REGION)
- [KEY_FILE](#KEY_FILE)
- [KEY_NAME](#KEY_NAME)
- [INSTANCE_TYPE](#INSTANCE_TYPE)
- [ENV](#ENV)
- [REGION](#REGION)
- [SSH_GIT_REPO](#SSH_GIT_REPO)
- [SSH_GIT_KEY](#SSH_GIT_KEY)
- [DNS_NAME](#DNS_NAME)
- [GIT_BRANCH](#GIT_BRANCH)
- [PROYECT_ENV_FILE](#PROYECT_ENV_FILE)
- [PROYECT_ENV](#PROYECT_ENV)

## Crear el plan de cracion de la infraestructura
Comando que crea un plan de terraform para crear la infraestructura.

`make  plan-infra ENV=$(ENV_VAR_VALUE) REGION=$(REGION_ENV_VALUE)`

## Crear infraestructura a partir del plan creado
Comando que ejecuta el plan de terraform para crear la infraestructura.

`make create-infra ENV=$(ENV_VAR_VALUE) REGION=$(REGION_ENV_VALUE)`

## Ejecutar tareas de ansible sobre la instancia ec2
se ejecutan las tareas para instalar git, docker y docker-compose as{i como para clonar el repositorio que se desea deployar.

`make provision-instance ENV=$(ENV_VAR_VALUE) REGION=$(REGION_ENV_VALUE)`

#### AWS_ACCESS_KEY_ID
aws access key correspondiente a un usuario de amazon.

#### AWS_SECRET_ACCESS_KEY
aws secret access key correspoindiente a un usuario de amazon.

#### AWS_DEFAULT_REGION
variable correspondiente a la region default para la cuenta de amazon.

#### KEY_FILE
ruta al archivo "key.pem" correspondiente a la llave privada descargada desde la consola de amazon.
#### KEY_NAME
Nombre de la llave creada en amazon.

#### INSTANCE_TYPE
Tamaño de la instancia de ec2 que se va a crear.

#### ENV
Variable para nombrar e identificar la infraestructura y la cual se agrega al nombre del dns.

#### REGION
Region en la cual se va a crear la infraestructura.

#### SSH_GIT_REPO
direccion del repo que sera clonado en la instancia.

#### SSH_GIT_KEY
direccion del archivo de la llave ssh que se usa para clonar el repositorio.

#### DNS_NAME
nombre del dns de route53 que se usara para relacionarlo con la imagen.

#### GIT_BRANCH
nombre de la rama que sera deployada en el proyecto.

#### PROYECT_ENV_FILE
direccion donde se encuentra el archivo con las variables que se usaran en el deployment.

#### PROYECT_ENV
valor que se usara para la variable de entorno ENV dentro del proyecto
