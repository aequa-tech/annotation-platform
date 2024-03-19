import { ApiUrl, QueryParams } from "./AnnotationContext";

async function CreateAnnotation(annotation){

  try {
    const response = await fetch(ApiUrl + QueryParams, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        // 'Authorization': 'Token ' + window.localStorage.getItem("auth_token")
      },
      body: JSON.stringify({"annotation": annotation})
    });
    const data = await response.json();
    console.log('Success:', data);
  } catch (error) {
    console.error('Error:', error);
  }
}

export { CreateAnnotation }

async function DeleteAnnotation(annotation){
  try {
    const response = await fetch(ApiUrl + QueryParams, {
      method: 'DELETE',
      headers: {
        'Content-Type': 'application/json',
        // 'Authorization': 'Token ' + window.localStorage.getItem("auth_token")
      },
      body: JSON.stringify({"id": annotation.id})
    });
    const data = await response.json();
    console.log('Success:', data);
  } catch (error) {
    console.error('Error:', error);
  }
}

export { DeleteAnnotation }


async function UpdateAnnotation(annotation){
  try {
    const response = await fetch(ApiUrl + QueryParams, {
      method: 'PUT',
      headers: {
        'Content-Type': 'application/json',
        // 'Authorization': 'Token ' + window.localStorage.getItem("auth_token")
      },
      body: JSON.stringify({"annotation": annotation})
    });
    const data = await response.json();
    console.log('Success:', data);
  } catch (error) {
    console.error('Error:', error);
  }
}

export { UpdateAnnotation }
