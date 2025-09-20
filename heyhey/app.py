"""
Hey Hey - A simple Flask webapp
"""

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
    app.run(debug=True)


if __name__ == '__main__':
    main()