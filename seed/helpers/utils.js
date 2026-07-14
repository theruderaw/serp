import { randomUUID } from 'crypto';

export function uuid() {
    return randomUUID();
}

export function randomItem(array) {
    return array[Math.floor(Math.random() * array.length)];
}