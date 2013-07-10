package net.croz.vaadinxtenddemo.api

import com.vaadin.ui.Component
import com.vaadin.ui.Alignment
import com.vaadin.ui.Layout$AlignmentHandler
import com.vaadin.ui.AbstractOrderedLayout

class ApiExtensions {
	static def alignment(Component it, Alignment align) {
		if (it.parent != null && it.parent instanceof AlignmentHandler) {
			(it.parent as AlignmentHandler).setComponentAlignment(it, align)
		}
	}
	
	static def expandRatio(Component it, float ratio) {
		if (it.parent != null && it.parent instanceof AbstractOrderedLayout) {
			(it.parent as AbstractOrderedLayout).setExpandRatio(it, ratio)
		}
	}
}