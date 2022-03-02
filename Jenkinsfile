// Declarative //
pipeline {
    agent any
    parameters {
        choice(name: 'BRANCH', choices: ['master'], description: 'Branch to deploy')
        choice(name: 'SCOPE', choices: ['Validate', 'Deploy'], description: 'Validate/Deploy metadata')
	    choice(name: 'COMMITS', choices: ['1', '2', '3', '4', '5','Package'], description: 'Number of commits or package to deploy')
        booleanParam(name: 'PMDALL', defaultValue: false, description: 'Run on all Apex classes')
        booleanParam(name: 'PMDFAIL', defaultValue: false, description: 'Exit pipeline on PMD violation')
        choice(name: 'TESTLEVEL', choices: ['NoTestRun', 'RunSpecifiedTests','RunLocalTests','RunAllTestsInOrg'], description: 'Deployment level')
        text(name: 'TESTS', defaultValue: '', description: 'Tests')
    }    
    environment {
	    SFDX_AUDIENCE_URL = "https://test.salesforce.com"
        APEX_LOG = "logs/apex.log.xml"
        SFDX_DISABLE_DNS_CHECK = "true"
    }

    stages {
        stage('Load env variables') {
            steps {
                script {
                        currentBuild.description = "${GIT_BRANCH}"
                        switch("${GIT_BRANCH}") {
                        case "main":
                        FILE_ID = "29d591b3-01be-475c-955c-e52cf61d0461"
                        break
                    }
                        configFileProvider([configFile(fileId: "${FILE_ID}", variable: 'JENV')]) {
                        CONFIG_FILE = readProperties file: "${JENV}"
						INSTANCE_URL = CONFIG_FILE['INSTANCE_URL']
                        //CREDENTIALS_ID = CONFIG_FILE['CREDENTIALS_ID']
			            CLIENT_ID = CONFIG_FILE['CLIENT_ID']
                        USER_NAME = CONFIG_FILE['USER_NAME']
                        PROJECT_DIR = CONFIG_FILE['PROJECT_DIR']
                        COMMITS_DIFF = CONFIG_FILE['COMMITS_DIFF']
                        ALIAS = CONFIG_FILE['ALIAS']
                    }
                }
            }
        }
        stage('Install SFDX') {
            steps {
                echo 'installing SFDX...' 
                sh """
                    node -v
                    npm -v
                    npm install -g sfdx-cli
                    sfdx --version
                """
            }
        }
        stage('Deploy') {
            environment {
                DEPLOYMENT_SCOPE = "-u ${ALIAS} -l ${params.TESTLEVEL}"
                FILES_DEPLOYMENT = ""
                TESTTIMEOUT = 5
            }	
            steps {
                echo 'Executing Deployment...'
                script {
                    if(params.TESTLEVEL == 'RunSpecifiedTests' && params.TESTS) {
                        DEPLOYMENT_SCOPE += " -r ${params.TESTS}"
                    } else if(params.TESTLEVEL == 'RunLocalTests') {
                        DEPLOYMENT_SCOPE += " -w ${TESTTIMEOUT}"
                    }
                    if(params.SCOPE == 'Validate') {
                        DEPLOYMENT_SCOPE += " -c"
                    } 
                    if(params.COMMITS == 'Package') {
                        echo "Deploying from package..."
                        DEPLOYMENT_SCOPE += " -x manifest/package.xml"
                    } else {
                        echo "Deploying from commits..."
			            //COMMITS_DIFF = sh "git --no-pager diff --diff-filter=ACMRTUXB --name-only HEAD~" 
			            echo "commit diff print ${COMMITS_DIFF}"
			            //COMMITS_DIFF = sh(returnStdout: true, script: "git --no-pager diff --diff-filter=ACMRTUXB --name-only HEAD~")
			            echo "printing commiting ${COMMITS_DIFF}"
			            echo "printing params ${COMMITS_DIFF}${params.COMMITS}"
			            echo "${Workspace}"
			            echo "${PWD}"
			    
                        FILES_DEPLOYMENT = sh(returnStdout: true, script: "${COMMITS_DIFF}${params.COMMITS} HEAD -- ${PROJECT_DIR} -- :!*package.xml -- !*.eslintrc.json | tr -s '\\n' ',' | sed 's/,\$//; s/.*/\"&\"/g'").trim()
			            //FILES_DEPLOYMENT = sh(returnStdout: true, script: "${COMMITS_DIFF}${params.COMMITS} HEAD -- ${PROJECT_DIR} -- :!*package.xml -- !*.eslintrc.json").trim()
                        echo "printing file deployment commiting ${FILES_DEPLOYMENT}"
			            DEPLOYMENT_SCOPE += " -p " + FILES_DEPLOYMENT
                    }
			

			        if(FILES_DEPLOYMENT == "" && params.COMMITS != 'Package') {
                        echo 'Nothing to deploy'
                        sh "exit 1"
                    }
					
                    withCredentials([file(credentialsId: 'CREDENTIALS_ID', variable: 'server_key_file')]) {
                    sh """
		    	        sfdx force:auth:jwt:grant --instanceurl "${INSTANCE_URL}" --clientid ${CLIENT_ID} --username "${USER_NAME}" --jwtkeyfile \"${server_key_file}\" --setalias ${ALIAS}
                         
                        sfdx force:source:deploy ${DEPLOYMENT_SCOPE}
                    """
                    }
                }
            }
        }
    }
}
// Script //
