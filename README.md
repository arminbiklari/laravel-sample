# build the project

there are 2 docker file one of them for php-fpm and install compose second one is for nginx 

docker build -t beekay6/laravel -f Dockerfile .

docker build -t beekay6/nginx -f Dockerfile-nginx .
# Deploy the project
1) create cluster with kind
   
     kind create cluster --config=kind.yaml
2) deploy mysq (bitnami offical helm chart)

    helm install -n laravel laravel-mysql mysql -f mysql/values.yaml
   
    Note: configure muysql in mysql chart values.yaml

3) deploy laravel sample app

   helm install -n laravel laravel-app laravel -f laravel/values.yaml
    in the values.yaml ingress enabled

    create php database migration in deployment yaml file with lifesycle and in this command use an entrypoint script for intiate of database configuration and migrration command
   
    health check also added on deployment yaml file and monitor "/" path in a spesific threshold
   
    all mysql credentials are put on secret and use as a environment variable
   
    for enable hpa, should enable hpa on values.yaml

    in this deployment use nginx as asidecar container to serve laravel files
