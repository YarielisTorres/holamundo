Pasos para Desplegar mi Aplicacion en Kubernetes

Iniciar en kubernet:
doctl auth init

1. Creación el Kubernete
  Comando:
          doctl kubernetes cluster create myapp-prueba --region nyc1 --node-pool "name=minodo;size=s-1vcpu-2gb;auto-scale=true;min-nodes=1;max-nodes=1"
   
2. Configurar el Kubernete
  Comando:
          doctl kubernetes cluster kubeconfig save cluster-id
3. Listar nodos:
  Comando:
          kubectl get nodes
   
4. Crear una imagen en Dockerhub de la Aplicación
  En caso de no poder crearla en docker hub, se crea directamente en el nodo 
   Comando:
           docker build -t myapp-image .

5.Configurar un registro de contenedores local:
Puedes usar Docker Registry como registro de contenedores local. Puedes ejecutar un contenedor Docker Registry en tu nodo Kubernetes
  Comando:
          docker run -d -p 5000:5000 --restart=always --name registry registry:2
        
6. Etiqueta tu imagen para que apunte al registro local
  Comando:
          docker tag myapp-image:latest localhost:5000/myapp-image:latest

7. Sube la imagen etiquetada al registro local (opcional: se debe hacer solo si la imagen es local)
  Comando:
          docker push localhost:5000/myapp-image:latest

8. Verificar en el manifiest.yaml
   containers:
      - name: myapp-container
        image: pool-79eh506b3-rx5gm/myapp-image:latest # Reemplaza esto con la imagen de la Aplicación
        ports:
        - containerPort: 80
          
9. Aplicar
    Comando:
           kubectl apply -f manifest.yaml

Opcional:
Si quieres exponer tu aplicación usando un servicio de tipo NodePort, puedes crear un archivo YAML
Comando:
        kubectl apply -f nombre-del-archivo.yaml
