import { ApiUrl } from "./AnnotationContext";

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
