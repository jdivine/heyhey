"""
Hey Hey - A simple Flask webapp
"""

import os
from flask import Flask, jsonify


def create_app():
    """Create and configure the Flask application."""
    app = Flask(__name__)
    
    @app.route('/')
    def hello_world():
        """Return a simple HTML page displaying Hello, World."""
        return "<h1>Hello, World</h1>"
    
    @app.route('/health')
    def health_check():
        """Return a JSON object with status ok."""
        return jsonify({"status": "ok"})
    
    return app


def main():
    """Main entry point for the application."""
    app = create_app()
    port = int(os.environ.get('PORT', 8080))
    host = os.environ.get('HOST', '0.0.0.0')
    app.run(debug=True, port=port, host=host)


if __name__ == '__main__':
    main()
