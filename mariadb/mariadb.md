



oc process -f mariadb-persistent-hostpath.yaml  | oc create -f -
 oc delete all,sa,secret -l template=mariadb-persistent-hostpath-template


 oc adm policy add-scc-to-user hostaccess -z mariadb





Try this:

On the phpMyAdmin default page (localhost) click on the "Privileges" link
Click on the "Add a new User link"
Assign the User a login and password
Where it says "Database for User" select "None"
Leave all checkboxes in global privileges unchecked
Press the "Go" button
You should see the new user in the User overview. Global privileges should say "Usage".

Click on the edit icon next the the User's account
Under "Database-specific privileges" where it says "Add privileges on the following database" chose the database(s) you wish to assign to the user
Assign the User whatever privileges you wish them to have for that database
Press the "Go" button

Create user fpipart and grant all access





PHPMyAdmin

Add to Porject
Language PHP
https://github.com/fabricepipart/phpMyAdmin.git



if curl -fs http://teknichrono-teknichrono-staging.router.default.svc.cluster.local > /dev/null; then echo "OK"; else echo "KO"; fi

while ! curl -fs http://teknichrono-teknichrono-staging.router.default.svc.cluster.local > /dev/null; do echo "Not started yet ..."; sleep 5; done



echo -e 'GET http://teknichrono-teknichrono-staging.router.default.svc.cluster.local HTTP/1.0\n\n' | nc teknichrono-teknichrono-staging.router.default.svc.cluster.local 80 > /dev/null 2>&1