import React, {Component} from 'react';
import Header from 'App/Header';
import AppStyles from 'App/AppStyles';

export default class App extends Component {
	render() {
		return <Header className={AppStyles.header} />;
	}
}
