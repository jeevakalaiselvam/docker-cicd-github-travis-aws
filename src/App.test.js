import { render, screen } from '@testing-library/react';
import App from './App';

test('renders application name link', () => {
    render(<App />);
    const linkElement = screen.getByText(/demo application/i);
    expect(linkElement).toBeInTheDocument();
});
