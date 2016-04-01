import FluxReduceStore from 'flux/lib/FluxReduceStore';
import Dispatcher from 'base/Dispatcher';

export default class FluxBaseStore extends FluxReduceStore {
  static _instance;

  static getInstance() {
    const isClient = typeof window !== 'undefined';

    if (isClient) {
      if (FluxBaseStore._instance) {
        return FluxBaseStore._instance;
      }

      FluxBaseStore._instance = new FluxBaseStore();
      return FluxBaseStore._instance;
    }

    return new FluxBaseStore();
  }

  constructor() {
    super(Dispatcher);
  }
}
