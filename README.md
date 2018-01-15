# Kenny Rogers - Salesforce Stuff for Kenny Rogers MobileCaddy App

[![Deploy](https://deploy-to-sfdx.com/dist/assets/images/DeployToSFDX.svg)](https://deploy-to-sfdx.com/)



## Set Up



    git clone https://github.com/forcedotcom/sfdx-simple.git

… or ...

    git clone git@github.com:forcedotcom/sfdx-simple.git

… to clone the repository. Then, open the directory.

    cd kenny-rogers-sfdc

## Steps

### Salesforce DX - Scratch Org

Authorize to your Developer Hub (Dev Hub) org.

    sfdx force:auth:web:login -d -a "Hub Org"

If you already have an authorized Dev Hub, set it as the default:

    sfdx force:config:set defaultdevhubusername=<username|alias>

Create a scratch org.

    sfdx force:org:create -s -f config/project-scratch-def.json

If you want to use an existing scratch org, set it as the default:

    sfdx force:config:set defaultusername=<username|alias>

Push your source.

    sfdx force:source:push

Run your tests.

    sfdx force:apex:test:run
    sfdx force:apex:test:report -i <id>

Open the scratch org.

    sfdx force:org:open --path one/one.app


### Salesforce DX - deploy into developer edition or production org

You can use the Salesforce CLI to deploy the source into a regular Salesforce org using the Metatdata API.

Authenticate against the deployment org
```
sfdx force:auth:web:login -a yourOrgAlias
```

Create an output directory for the to be converted source
```
mkdir mdapi
```

Convert the source from Salesforce DX format to Metatdata API format
```
sfdx force:source:convert -r force-app -d mdapi
```

Deploy the source
```
sfdx force:mdapi:deploy -d mdapi -u yourOrgAlias
```


## Resources

For details on using sfdx-simple, please review the [Salesforce DX Developer Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev).

## Description of Files and Directories

* **sfdx-project.json**: Required by Salesforce DX. Configures your project.  Use this file to specify the parameters that affect your Salesforce development project.
* **config/project-scratch-def.json**: Sample file that shows how to define the shape of a scratch org.  You reference this file when you create your scratch org with the force:org:create command.
* **force-app**: Directory that contains the source for the sample Force.com app and tests.
* **.project**:  Required by the Eclipse IDE.  Describes the Eclipse project.
* **.gitignore**:  Optional Git file. Specifies intentionally untracked files that you want Git (or in this case GitHub) to ignore.

## Issues

Please log issues related to this repository [here](https://github.com/forcedotcom/sfdx-simple/issues).
