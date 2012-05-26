package com.poker;

import java.util.LinkedList;
import java.util.Collections;
import java.util.Random;

public class Deck {

	private LinkedList<Card> playingCards = new LinkedList<Card>();
	private LinkedList<Card> usedCards = new LinkedList<Card>();
	//DeckState Enum?
	private boolean isShuffled = false;
	
	Deck(){
		initializeDeck();
	}
	
	private void initializeDeck(){
		for (Suit suit : Suit.values()) {
			  for(Value value : Value.values()){
				  playingCards.add(new Card(suit, value));
			  }
		}
	}
	
	public void shuffle(){
		returnUsedCards();
		long seed = System.nanoTime();
		Collections.shuffle(this.playingCards, new Random(seed));
		this.setShuffled(true);
	}

	private void returnUsedCards() {
		while(!usedCards.isEmpty()){
			playingCards.add(usedCards.pop());	
		}
	}

	public boolean isShuffled() {
		return isShuffled;
	}

	public void setShuffled(boolean isShuffled) {
		this.isShuffled = isShuffled;
	}
	
	public Card getNextCard(){
		if(isShuffled()){
			Card card = playingCards.pop();
			usedCards.add(card);
			return card;
		} else {
			shuffle();
			return getNextCard();
		}
	}
	
}