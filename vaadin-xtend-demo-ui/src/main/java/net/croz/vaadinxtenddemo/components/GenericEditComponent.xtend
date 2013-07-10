package net.croz.vaadinxtenddemo.components

import com.vaadin.data.fieldgroup.BeanFieldGroup
import com.vaadin.data.util.BeanItem
import com.vaadin.ui.AbstractField
import com.vaadin.ui.TextField
import com.vaadin.ui.VerticalLayout
import com.vaadin.ui.Window
import com.vaadin.ui.themes.Reindeer
import java.beans.Introspector
import java.util.Collection

import static extension net.croz.vaadinxtenddemo.api.BuilderExtensions.*

class GenericEditComponent<TSource> extends VerticalLayout {
	new(Class<TSource> beanType, TSource instance) {
		val fieldGroup = new GenericBeanFieldGroup(beanType);
		fieldGroup.itemDataSource = new BeanItem(instance)
		fieldGroup.buffered = true
		this => [
			setSizeUndefined
			width = "400px"
			spacing = true
			margin = true
			for (Object propertyId : fieldGroup.unboundPropertyIds) {
				val field = fieldGroup.buildAndBind(propertyId)
				if (field instanceof TextField) {
					(field as TextField).nullRepresentation = ""
				}
				(field as AbstractField).immediate = true
				addComponent(field);
			}
			horizontalLayout [
				button [
					caption = "Save"
					addClickListener [fieldGroup.commit]
				]
				button [
					caption = "Cancel"
					addStyleName = Reindeer::BUTTON_LINK
					addClickListener [(this.parent as Window).close]
				]
			]
		];

	}
}

class GenericBeanFieldGroup<TSource> extends BeanFieldGroup<TSource> {

	val Class<TSource> beanType

	new(Class<TSource> beanType) {
		super(beanType)
		this.beanType = beanType
	}

	override getUnboundPropertyIds() {
		if (itemDataSource != null) {
			return super.unboundPropertyIds;
		}

		val info = Introspector::getBeanInfo(beanType);
		val unboundPropertyIds = info.propertyDescriptors.filter[i|
			i.readMethod.declaringClass == info.beanDescriptor.beanClass && i.name != "class"].map["_" + it.name].toList

		unboundPropertyIds.removeAll(boundPropertyIds)
		return unboundPropertyIds as Collection
	}

}
