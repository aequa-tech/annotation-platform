import { useState } from 'react';
import { Modal, Button, Alert } from 'react-bootstrap';

async function CompleteTask(path) {
  try {
    const response = await fetch(path, {
      method: 'PATCH',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
      }
    });
    const data = await response.json();
    console.log('Success:', data);
    return data;
  } catch (error) {
    console.error('Error:', error);
    throw error;
  }
}

function ConfirmationModal({ completePath, label }) {
  const [show, setShow] = useState(false);
  const [success, setSuccess] = useState(false);

  const handleClose = () => setShow(false);
  const handleShow = () => setShow(true);
  const handleComplete = async () => {
    try {
      await CompleteTask(completePath);
      setSuccess(true);
      handleClose();
    } catch (error) {
      setSuccess(false);
    }
  }

  if (success) {
    return (
      <Alert className="position-absolute top-0 start-50 translate-middle-x" variant="success" dismissible>
        Task completed successfully!
      </Alert>
    );
  }

  return (
    <>
      <Button variant="primary" className="position-relative bg-success-soft py-1 smaller rounded-sm border-0 bg-success-soft btn-noshadow" onClick={handleShow}>
        <span className="link-normal text-decoration-underline">{label}</span>
      </Button>

      <Modal show={show} onHide={handleClose}>
        <Modal.Header closeButton>
          <Modal.Title>Confirm Completion</Modal.Title>
        </Modal.Header>
        <Modal.Body>Are you sure you want to complete this task?</Modal.Body>
        <Modal.Footer>
          <Button variant="secondary" onClick={handleClose}>
            Cancel
          </Button>
          <Button variant="primary" onClick={handleComplete}>
            Confirm
          </Button>
        </Modal.Footer>
      </Modal>
    </>
  );
}

export default ConfirmationModal;
