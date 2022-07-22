pipeline {
    agent any
    parameters {
            choice(
            name: 'terraformwork',
            choices: ['creat_infra', 'destroy_infra'],
            description: 'terraformwork')

    }


    stages {

    stage(creat){
        when {
              expression { params.terraformwork == 'creat_infra' }
                   }
            steps {
            echo "creating_infra"
//             sh 'cd project/ecs'
            sh 'terraform init project/ecs'
            sh 'terraform apply -auto-approve project/ecs'
            }
            }
        stage(destroy) {

         when {
               expression { params.terraformwork == 'destroy_infra' }
                }
              steps{
              echo "destroying_infra"
              sh ''
              sh 'terraform destroy -auto-approve'
              }
            }
       }

}
