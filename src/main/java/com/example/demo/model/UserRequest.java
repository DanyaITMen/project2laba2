package com.example.demo.model;

public record UserRequest(String username, String password, String role) {
}
//потрібен для того, щоб приймати дані від користувача, коли він заповнює форму