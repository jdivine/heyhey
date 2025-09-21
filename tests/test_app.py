"""
Unit tests for the Hey Hey Flask webapp
"""

import pytest
from app.app import create_app


@pytest.fixture
def client():
    """Create a test client for the Flask application."""
    app = create_app()
    app.config['TESTING'] = True
    with app.test_client() as client:
        yield client


def test_hello_world(client):
    """Test the '/' endpoint returns Hello, World HTML page."""
    response = client.get('/')
    assert response.status_code == 200
    assert response.mimetype == 'text/html'
    assert b'<h1>Hello, World</h1>' in response.data


def test_health_check(client):
    """Test the '/health' endpoint returns JSON with status ok."""
    response = client.get('/health')
    assert response.status_code == 200
    assert response.mimetype == 'application/json'
    json_data = response.get_json()
    assert json_data == {"status": "ok"}
