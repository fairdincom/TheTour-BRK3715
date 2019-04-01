# Sample3 - Terraform 모듈화
Terraform을 조직단위로 사용하기 위해서는 어느정도 인프라 추상화가 필요 할 것이다. 그에 따라 terraform을 이용하여 리소스를 배포할 시 모듈화를 하여 terraform을 배포할 수 있다.

여기서는 Azure backend 설정이 되어있으므로 Sample2를 실습한 후 진행하는 것이 권장사항이다. Smaple1에서 생성한 모든 리소스를 모듈화 방식으로 리소스를 제작한다.

## 사용되는 버전
    ```
    Terraform v0.11.13
    Azure providwe v1.23.0
    ```

## 생성되는 리소스
- Resource Group
- Storage Account
- App Servic Plan - Consumction Plan
- Function App
- Service Bus Namespace
- Service Bus Topic

## 참조하는 변수
- resource_group_name           (type=string)
- resource_location             (type=string, default=southeastasia)
- resource_location_code        (type=string, default=sea)
- resource_environment          (type=string, default=development)
- resource_environment_code     (type=string, default=dev)
- resource_tags                 (type=map,    default=enviroment="development")

## 실습
1. main.tf 파일을 열어 다음과 같은 내용을 Sample2에서 확인한 값으로 변경한다.
    ```
    terraform {
      backend "azurerm" {
        storage_account_name  = "storage_account_name"
        container_name        = "container_name"
        key                   = "brk3715.terraform.tfstate"
        access_key            = "access_key"
      }
    }
    ```

2. terraform init을 이용하여 초기화 한다.
    ```terraform cli
    terraform init
    ```

3. .tf 파일이 정상인지 확인한다.
    ```terraform cli
    terraform plan -var "resource_name=[RESOURCE_NAME]"
    ```

4. Azure에 Resource를 배포한다.
    ```terraform cli
    terraform apply -var "resource_name=[RESOURCE_NAME]" -auto-approve
    ```