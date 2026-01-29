🚀 Projeto Loja Veloz - Cloud Native & DevOps
Este repositório contém a implementação da arquitetura de microsserviços para a Loja Veloz, focada em escalabilidade, resiliência e segurança. O projeto abrange desde o desenvolvimento local com Docker Compose até a orquestração profissional com Kubernetes e automação via CI/CD.

🏗️ Arquitetura do Sistema
A aplicação é composta por 4 microsserviços independentes:

API Gateway: Ponto de entrada, responsável pelo roteamento e Tracing Distribuído.

Serviço de Pedidos: Core business, integrado ao banco de dados PostgreSQL.

Serviço de Estoque: Controle de inventário.

Serviço de Pagamentos: Processamento de transações.

🛠️ Tecnologias Utilizadas
Runtime: Node.js 18 (Alpine Images)

Containerização: Docker & Docker Compose

Orquestração: Kubernetes (Minikube/EKS)

Infraestrutura como Código: Terraform

CI/CD: GitHub Actions

Banco de Dados: PostgreSQL

🚀 Como Executar o Projeto
1. Ambiente Local (Docker Compose)
Para subir todos os serviços, redes e volumes com um único comando:

Bash
docker-compose up --build
Acesse o Gateway em: http://localhost:8080

2. Ambiente de Produção (Kubernetes)
Certifique-se de que o seu cluster (Minikube) está rodando e execute a aplicação dos manifestos na ordem correta:

Bash
# 1. Configurações e Segredos
kubectl apply -f k8s/postgres-secrets.yaml
kubectl apply -f k8s/pedidos-configmap.yaml

# 2. Infraestrutura de Banco
kubectl apply -f k8s/postgres-deployment.yaml

# 3. Microsserviços
kubectl apply -f k8s/api-gateway.yaml
kubectl apply -f k8s/pedidos.yaml
kubectl apply -f k8s/estoque.yaml
kubectl apply -f k8s/pagamentos.yaml

# 4. Escalonamento Automático
kubectl apply -f k8s/hpa.yaml
🛡️ Boas Práticas Implementadas
Conteinerização e Segurança
User Non-Root: Todos os Dockerfiles utilizam USER appuser para evitar privilégios elevados.

Imagens Enxutas: Uso de imagens base alpine e limpeza de cache do NPM para reduzir a superfície de ataque.

Secrets: Credenciais de banco de dados nunca estão no código; são injetadas via Kubernetes Secrets.

Resiliência e Escala
Probes: Implementação de Liveness e Readiness probes para garantir o self-healing do cluster.

Estratégia de Deploy: Configurado como RollingUpdate para garantir zero downtime durante atualizações.

HPA (Horizontal Pod Autoscaler): Configurado para escalar o serviço de Pedidos automaticamente caso o uso de CPU exceda 50%.

Observabilidade e Tracing
Tracing Distribuído: Implementação manual de x-trace-id que correlaciona logs entre o Gateway e os serviços internos.

Logs Estruturados: Saída padronizada no console para captura por agregadores de logs.

🤖 CI/CD Pipeline
Nosso pipeline no GitHub Actions realiza automaticamente:

Lint & Test: Validação da qualidade do código.

Build & Scan: Criação das imagens Docker e varredura de vulnerabilidades.

Push: Publicação das imagens versionadas no Docker Hub/Registry.

📁 Estrutura do Repositório
Plaintext
├── terraform/          # IaC para provisionamento do cluster
├── k8s/                # Manifestos de Deployment, Service, HPA e Secrets
├── api-gateway/        # Código fonte e Dockerfile do Gateway
├── pedidos/            # Código fonte e Dockerfile de Pedidos
├── estoque/            # Código fonte e Dockerfile de Estoque
├── pagamentos/         # Código fonte e Dockerfile de Pagamentos
├── docker-compose.yml  # Orquestração local
└── .github/workflows/  # Definição do pipeline de CI/CD