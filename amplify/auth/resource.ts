import { referenceAuth } from '@aws-amplify/backend';


export const auth = referenceAuth({
  userPoolId: 'eu-central-1_MYqrUIncW',
  identityPoolId: 'eu-central-1:96eaf241-4a43-432e-87ac-746a5b5ea80e',
  authRoleArn: 'arn:aws:iam::002835364305:role/service-role/MOE-Frankfurt-IDpool-AuthRole',
  unauthRoleArn: 'arn:aws:iam::002835364305:role/service-role/MOE-Frankfurt-IDpool-UnAuthRole',
  userPoolClientId: '6533p0vocceiuphmlpj9lorjij',

});