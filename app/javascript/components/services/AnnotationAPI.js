import { ApiUrl, TaskContext } from "./AnnotationContext";

async function GetTexline(texlineId) {
  try {
    const response = await fetch(`/api/v1/tasks/${TaskContext._currentValue}/text_lines/${texlineId}`, {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json',
        // 'Authorization': 'Token ' + window.localStorage.getItem("auth_token")
      },
    });
    const data = await response.json();
    console.log('Success:', data);
    return data;
  } catch (error) {
    console.error('Error:', error);
  }
}

export { GetTexline }

async function CreateAnnotation(annotation){

  try {
    const response = await fetch(ApiUrl, {
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
    const response = await fetch(ApiUrl, {
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
    const response = await fetch(ApiUrl, {
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

async function GetTaxonomies(){
  try {
    const response = await fetch(`/api/v1/tasks/${TaskContext._currentValue}/taxonomies/`);
    const data = await response.json();
    return data;
  } catch (error) {
    console.error('Error:', error);
  }
}

export { GetTaxonomies }
