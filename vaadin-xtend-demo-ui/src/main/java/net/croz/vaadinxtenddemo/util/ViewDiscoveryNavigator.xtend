package net.croz.vaadinxtenddemo.util

import ru.xpoft.vaadin.DiscoveryNavigator
import com.vaadin.ui.UI
import com.vaadin.ui.ComponentContainer
import com.vaadin.navigator.View
import java.util.List
import java.util.ArrayList
import com.vaadin.ui.SingleComponentContainer
import com.vaadin.navigator.NavigationStateManager
import com.vaadin.navigator.ViewDisplay

@Data
class ViewDescription {
	String name
	Class<? extends View> viewClass
}

class ViewDiscoveryNavigator extends DiscoveryNavigator {

	private List<ViewDescription> viewDescriptions

	new(UI ui, SingleComponentContainer container) {
		super(ui, container)
	}

	new(UI ui, ComponentContainer container) {
		super(ui, container)
	}

	new(UI ui, NavigationStateManager stateManager, ViewDisplay display) {
		super(ui, stateManager, display)
	}

	new(UI ui, ViewDisplay display) {
		super(ui, display)
	}

	def getViewDescriptions() {
		if (viewDescriptions == null) {
			viewDescriptions = new ArrayList<ViewDescription>()
		}
		return viewDescriptions
	}

	override protected addBeanView(String viewName, String beanName, Class<? extends View> viewClass, boolean cached) {
		getViewDescriptions().add(new ViewDescription(viewName, viewClass))
		super.addBeanView(viewName, beanName, viewClass, cached)
	}

}
