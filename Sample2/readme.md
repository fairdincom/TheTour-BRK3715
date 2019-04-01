# Sample2 - Terraform Backend 구성을 위한 Storage Account 생성
Terraform을 실행하면 현재 구성된 리소스의 구성을 저장하는 .tfstate파일이 생성된다. 기본 값으로는 terraform 명령어를 실행한 디렉토리에 생성되며, 이는 .tfstate 파일이 삭제 되거나 여러 명이 동시에 인프라 변경을 해야 할 시 이슈를 겪게 된다.
이를 방지하기 위해 .tfstate 파일을 외부 저장소에 저장한 후 공유하거나, 백업을 하는 것이 좋다. 여기서는 Azure Storage Account에 .tfstate 파일을 저장할 수 있도록 Sotrage Account를 구성한다.

## 사용되는 버전
    ```
    Terraform v0.11.13
    Azure providwe v1.23.0
    ```

## 생성되는 리소스
- Resource Group
- Storage Account
- Blob

## 참조하는 변수
- resource_name     (type=string)
- resource_location (type=string, default=southeastasia)

## 실습
1. terraform init을 이용하여 초기화 한다.
    ```terraform cli
    terraform init
    ```

2. .tf 파일이 정상인지 확인한다.
    ```terraform cli
    terraform plan -var "resource_name=[RESOURCE_NAME]"
    ```

3. Azure에 Resource를 배포한다.
    ```terraform cli
    terraform apply -var "resource_name=[RESOURCE_NAME]" -auto-approve
    ```

4. 실행이 완료된 후 다음 명령어를 사용하여 생성된 리소스 목록을 확인한다
    ```terraform cli
    terraform state show
    ```
    ```output
    $ terraform state list
    azurerm_management_lock.resource-group-level
    azurerm_resource_group.tstate
    azurerm_storage_account.tstate
    azurerm_storage_container.tstate
    ```

5. 출력된 결과에서 다음 명령어를 이용하여 **storage account name**, **container name**, **access key**값을 얻어온다.
    ```terraform cli
    terraform state show azurerm_storage_account.tstate
    terraform state show azurerm_storage_container.tstate
    ```
    ```output
    $ terraform state show azurerm_storage_account.tstate
    id                             = /subscriptions/.../storageAccounts/storage_account_name
    access_tier                    =
    ...
    location                       = southeastasia
    name                           = storage_account_name
    network_rules.#                = 0
    primary_access_key             = access_key
    ...
    
    $ terraform state show azurerm_storage_container.tstate
    id                        = https://storage_account_name.blob.core.windows.net/blob_name
    container_access_type     = private
    name                      = blob_name
    ...
    ```