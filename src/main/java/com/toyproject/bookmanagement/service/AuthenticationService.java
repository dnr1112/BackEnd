package com.toyproject.bookmanagement.service;

import org.springframework.stereotype.Service;

import com.toyproject.bookmanagement.exception.CustomException;
import com.toyproject.bookmanagement.exception.ErrorMap;
import com.toyproject.bookmanagement.repository.UserRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AuthenticationService {
	
	private final UserRepository userRepository;

	public void checkDuplicatedEmail(String email) {
		if(userRepository.findUserByEmail(email) != null) {
			throw new CustomException("DuplicatedEmail",
					ErrorMap.builder().put("email", "사용중인 이메일 입니다.").build());
		}
	}
}
